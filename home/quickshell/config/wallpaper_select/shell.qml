import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell.Wayland

PanelWindow {
    id: main

    // ---- Settings ----
    property int animDuration: 100

    property real zoomScale: 0.8
    property real edgeScale: 0.3
    property real skewFactor: 0
    property int baseSpacing: 8
    property real mouseSensitivity: 1.0

    // ---- Inertia ----
    property real inertiaDecay: 0.90
    property int inertiaDuration: 1800
    property real inertiaVelocityThreshold: 0.00005

    // ---- Centering ----
    property int centerDelay: 120
    property int centerDuration: 180
    property real centerVelocityThreshold: 0.002

    anchors {
        left: true
        right: true
    }

    implicitHeight: Screen.height * 0.66

    color: "transparent"
    aboveWindows: true
    exclusionMode: "Ignore"
    exclusiveZone: 1

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    Component.onCompleted: {
        Quickshell.execDetached([
            "bash",
            Quickshell.shellPath("cache.sh"),
            Quickshell.shellDir
        ])
    }

    FileView {
        path: Quickshell.shellPath("config.json")
        watchChanges: true

        onFileChanged: reload()

        JsonAdapter {
            id: configs

            property string wallpaper_path
            property string cache_path
            property int number_of_pictures
            property string border_color
        }
    }

    FolderListModel {
        id: folderModel

        folder: "file://" + configs.wallpaper_path
        showDirs: false
        nameFilters: ["*.png", "*.jpg"]
        sortField: FolderListModel.Name
    }

    Item {
        id: controller

        anchors.fill: parent
        focus: true

        // ---- Layout ----

        readonly property real tileWidth: {
            if (configs.number_of_pictures <= 0)
                return width

            return width / Math.min(configs.number_of_pictures, 6)
        }

        readonly property real viewportCenterX: width / 2

        // ---- Position ----

        property real scrollPosition: 0
        property real targetPosition: 0

        readonly property int selectedIndex:
            clampIndex(Math.round(scrollPosition))

        // ---- State ----

        property bool mouseDragging: false
        property bool inertiaRunning: false
        property bool keyboardMovement: false

        // ---- Velocity ----

        property real scrollVelocity: 0
        property real previousScrollPosition: 0
        property double previousScrollTime: 0

        // ---- Inertia State ----

        property real inertiaVelocity: 0
        property double inertiaLastTime: 0
        property int inertiaElapsed: 0

        // =========================================================
        // POSITION
        // =========================================================

        function clampIndex(index) {
            if (folderModel.count <= 0)
                return 0

            return Math.max(
                0,
                Math.min(index, folderModel.count - 1)
            )
        }

        function clampPosition(position) {
            if (folderModel.count <= 1)
                return 0

            return Math.max(
                0,
                Math.min(position, folderModel.count - 1)
            )
        }

        // =========================================================
        // VELOCITY
        // =========================================================

        onScrollPositionChanged: {
            const now = Date.now()

            if (previousScrollTime > 0) {
                const dt = Math.max(1, now - previousScrollTime)

                scrollVelocity =
                    (scrollPosition - previousScrollPosition) / dt
            }

            previousScrollPosition = scrollPosition
            previousScrollTime = now
        }

        // =========================================================
        // CENTERING
        // =========================================================

        function centerSelected() {
            if (folderModel.count <= 0)
                return

            if (mouseDragging || inertiaRunning)
                return

            if (
                !keyboardMovement &&
                Math.abs(scrollVelocity) > centerVelocityThreshold
            ) {
                centerTimer.restart()
                return
            }

            targetPosition = selectedIndex
            centerAnimation.restart()
        }

        function scheduleCenter() {
            if (mouseDragging || inertiaRunning)
                return

            centerTimer.restart()
        }

        // =========================================================
        // SELECTION
        // =========================================================

        function select(index) {
            if (folderModel.count <= 0)
                return

            positionAnimation.stop()
            stopInertia()
            centerAnimation.stop()
            centerTimer.stop()

            targetPosition = clampIndex(index)
            positionAnimation.restart()
        }

        function move(delta) {
            keyboardMovement = true
            select(selectedIndex + delta)
        }

        function wheelMove(delta) {
            keyboardMovement = false
            select(selectedIndex + delta)
        }

        // =========================================================
        // INERTIA
        // =========================================================

        function startInertia(velocity) {
            if (Math.abs(velocity) <= inertiaVelocityThreshold) {
                scheduleCenter()
                return
            }

            inertiaVelocity = velocity
            inertiaLastTime = Date.now()
            inertiaElapsed = 0
            inertiaRunning = true

            inertiaTimer.restart()
        }

        function updateInertia() {
            if (!inertiaRunning)
                return

            const now = Date.now()
            const dt = Math.max(1, now - inertiaLastTime)

            inertiaLastTime = now
            inertiaElapsed += dt

            const movement = inertiaVelocity * dt

            const nextPosition = clampPosition(
                scrollPosition + movement
            )

            // Stop at either end of the strip.
            if (
                Math.abs(nextPosition - scrollPosition) < 0.000001
            ) {
                stopInertia()
                scheduleCenter()
                return
            }

            scrollPosition = nextPosition

            // Apply decay after this frame's movement.
            inertiaVelocity *= Math.pow(
                inertiaDecay,
                dt / 16
            )

            if (Math.abs(inertiaVelocity) <= inertiaVelocityThreshold) {
                stopInertia()
                scheduleCenter()
                return
            }

            if (inertiaElapsed >= inertiaDuration) {
                stopInertia()
                scheduleCenter()
            }
        }

        function stopInertia() {
            inertiaTimer.stop()

            inertiaRunning = false
            inertiaVelocity = 0
            inertiaLastTime = 0
            inertiaElapsed = 0
        }

        // =========================================================
        // ACTIVATION
        // =========================================================

        function activateCurrent() {
            if (folderModel.count <= 0)
                return

            const path = folderModel.get(
                selectedIndex,
                "filePath"
            )

            Quickshell.execDetached([
                "bash",
                Quickshell.shellPath("commands.sh"),
                path
            ])

            Qt.quit()
        }

        // =========================================================
        // KEYBOARD
        // =========================================================

        Keys.onPressed: function(event) {
            const big = configs.number_of_pictures

            switch (event.key) {
            case Qt.Key_J:
                move(1)
                break

            case Qt.Key_K:
                move(-1)
                break

            case Qt.Key_D:
                move(big)
                break

            case Qt.Key_U:
                move(-big)
                break

            case Qt.Key_Space:
            case Qt.Key_Return:
                activateCurrent()
                break

            case Qt.Key_Escape:
                Qt.quit()
                break

            default:
                return
            }

            event.accepted = true
        }

        // =========================================================
        // POSITION ANIMATION
        // =========================================================

        NumberAnimation {
            id: positionAnimation

            target: controller
            property: "scrollPosition"
            to: controller.targetPosition

            duration: main.animDuration
            easing.type: Easing.OutCubic

            onFinished: {
                if (controller.keyboardMovement) {
                    controller.keyboardMovement = false
                    controller.centerSelected()
                } else {
                    controller.scheduleCenter()
                }
            }
        }

        // =========================================================
        // INERTIA TIMER
        // =========================================================

        Timer {
            id: inertiaTimer

            interval: 16
            repeat: true

            onTriggered: controller.updateInertia()
        }

        // =========================================================
        // CENTERING ANIMATION
        // =========================================================

        NumberAnimation {
            id: centerAnimation

            target: controller
            property: "scrollPosition"
            to: controller.targetPosition

            duration: main.centerDuration
            easing.type: Easing.OutCubic

            onFinished: controller.scrollVelocity = 0
        }

        // =========================================================
        // CENTER DELAY
        // =========================================================

        Timer {
            id: centerTimer

            interval: main.centerDelay
            repeat: false

            onTriggered: {
                if (controller.mouseDragging)
                    return

                if (controller.inertiaRunning) {
                    restart()
                    return
                }

                if (controller.keyboardMovement) {
                    controller.centerSelected()
                    return
                }

                if (
                    Math.abs(controller.scrollVelocity) >
                    controller.centerVelocityThreshold
                ) {
                    restart()
                    return
                }

                controller.centerSelected()
            }
        }

        // =========================================================
        // MOUSE INPUT
        // =========================================================

        MouseArea {
            id: inputBar

            anchors.fill: parent
            hoverEnabled: true

            property bool dragging: false

            property real pressX: 0
            property real pressPosition: 0

            property real lastX: 0
            property real lastTime: 0
            property real mouseVelocity: 0

            onPressed: function(mouse) {
                dragging = true

                controller.mouseDragging = true
                controller.keyboardMovement = false

                positionAnimation.stop()
                controller.stopInertia()
                centerAnimation.stop()
                centerTimer.stop()

                pressX = mouse.x
                pressPosition = controller.scrollPosition

                lastX = mouse.x
                lastTime = Date.now()
                mouseVelocity = 0
            }

            onPositionChanged: function(mouse) {
                if (!dragging)
                    return

                const now = Date.now()
                const dt = Math.max(1, now - lastTime)
                const dx = mouse.x - lastX

                const instantVelocity = dx / dt

                mouseVelocity =
                    mouseVelocity * 0.35 +
                    instantVelocity * 0.65

                lastX = mouse.x
                lastTime = now

                const delta =
                    (mouse.x - pressX) /
                    controller.tileWidth *
                    main.mouseSensitivity

                controller.scrollPosition =
                    controller.clampPosition(
                        pressPosition - delta
                    )
            }

            onReleased: {
                if (!dragging)
                    return

                dragging = false
                controller.mouseDragging = false

                const thumbnailVelocity =
                    -mouseVelocity /
                    controller.tileWidth *
                    main.mouseSensitivity

                controller.startInertia(thumbnailVelocity)
            }

            onCanceled: {
                dragging = false
                controller.mouseDragging = false

                controller.scheduleCenter()
            }

            onWheel: function(wheel) {
                const delta =
                    wheel.angleDelta.y > 0 ? -1 : 1

                controller.wheelMove(delta)

                wheel.accepted = true
            }
        }

        // =========================================================
        // THUMBNAILS
        // =========================================================

        Repeater {
            id: repeater

            model: folderModel

            delegate: Item {
                id: tile

                // ---- Dimensions ----

                readonly property real baseWidth:
                    controller.tileWidth

                readonly property real baseHeight:
                    controller.height

                // ---- Position ----

                readonly property real positionDistance:
                    index - controller.scrollPosition

                readonly property real absoluteDistance:
                    Math.abs(positionDistance)

                readonly property bool active:
                    index === controller.selectedIndex

                // ---- Scale ----

                property real scaleFactor: {
                    const range = Math.max(
                        1,
                        configs.number_of_pictures / 2
                    )

                    const fraction = Math.min(
                        1,
                        absoluteDistance / range
                    )

                    const smooth =
                        1 -
                        fraction *
                        fraction *
                        (3 - 2 * fraction)

                    return main.edgeScale +
                        (
                            main.zoomScale -
                            main.edgeScale
                        ) * smooth
                }

                readonly property real visualWidth:
                    baseWidth * scaleFactor

                readonly property real visualHeight:
                    baseHeight * Math.min(1, scaleFactor)

                // =================================================
                // POSITION
                // =================================================

                function centerForIndex() {
                    const position = controller.scrollPosition
                    const lower = Math.floor(position)
                    const fraction = position - lower

                    const anchor = Math.max(
                        0,
                        Math.min(
                            lower,
                            folderModel.count - 1
                        )
                    )

                    let center = controller.viewportCenterX
                    let anchorToNext = 0

                    if (anchor < folderModel.count - 1) {
                        const current = repeater.itemAt(anchor)
                        const next = repeater.itemAt(anchor + 1)

                        if (current && next) {
                            anchorToNext =
                                current.visualWidth / 2 +
                                main.baseSpacing +
                                next.visualWidth / 2
                        }
                    }

                    center -= fraction * anchorToNext

                    // Position to the right of the anchor.
                    if (index > anchor) {
                        for (let i = anchor; i < index; ++i) {
                            const left = repeater.itemAt(i)
                            const right = repeater.itemAt(i + 1)

                            if (!left || !right)
                                continue

                            center +=
                                left.visualWidth / 2 +
                                main.baseSpacing +
                                right.visualWidth / 2
                        }

                        return center
                    }

                    // Position to the left of the anchor.
                    if (index < anchor) {
                        for (let i = anchor; i > index; --i) {
                            const right = repeater.itemAt(i)
                            const left = repeater.itemAt(i - 1)

                            if (!left || !right)
                                continue

                            center -=
                                right.visualWidth / 2 +
                                main.baseSpacing +
                                left.visualWidth / 2
                        }
                    }

                    return center
                }

                readonly property real visualCenter:
                    centerForIndex()

                width: visualWidth
                height: visualHeight

                x: visualCenter - width / 2
                y: (controller.height - height) / 2

                // =================================================
                // CONTENT
                // =================================================

                Item {
                    id: content

                    anchors.fill: parent

                    Text {
                        id: alt

                        text: ""
                        color: configs.border_color

                        anchors.centerIn: parent

                        font.pixelSize: 16

                        transform: Shear {
                            xFactor: main.skewFactor
                        }
                    }

                    Image {
                        id: img

                        anchors.fill: parent

                        fillMode: Image.PreserveAspectCrop

                        asynchronous: true
                        cache: false
                        smooth: true

                        source:
                            "file://" +
                            configs.cache_path +
                            fileName

                        sourceSize.width:
                            tile.baseWidth * main.zoomScale

                        sourceSize.height:
                            tile.baseHeight

                        transform: Shear {
                            xFactor: main.skewFactor
                        }

                        Timer {
                            id: retryTimer

                            interval: 1000
                            repeat: false

                            onTriggered: {
                                const source = img.source

                                img.source = ""
                                img.source = source
                            }
                        }

                        onStatusChanged: {
                            if (status === Image.Error) {
                                alt.text = "Caching"
                                retryTimer.start()
                            }
                        }
                    }

                    Rectangle {
                        id: border

                        z: 10
                        anchors.fill: parent

                        visible: tile.active

                        color: "transparent"

                        border.width: 2
                        border.color: configs.border_color

                        transform: Shear {
                            xFactor: main.skewFactor
                        }
                    }
                }
            }
        }
    }
}
