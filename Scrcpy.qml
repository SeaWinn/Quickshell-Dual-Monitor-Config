import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
    id: mainRectangle

    property var colors 
    

    topLeftRadius: 8
    topRightRadius: 8
    bottomLeftRadius: 0
    bottomRightRadius: 0

    implicitHeight: hoverHandler.hovered ? mainRectangle.width - buttonSpacing : 20
    implicitWidth: 200
    color: colors.background

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 590
            easing.type: Easing.InOutCubic
        }
    }

    // clip: true

    HoverHandler {
        id: hoverHandler
        cursorShape: Qt.PointingHandCursor
    }

    Process {
        id: proc
    }

    property int rowNumber: 3
    property int columnNumber: 3
    property int widgetMargin: 15
    property int buttonSpacing: 5
    property int buttonSize: (mainRectangle.width - (widgetMargin * 2) - (buttonSpacing * (columnNumber - 1))) / columnNumber
    property var buttons: [
        { icon: "󰄀", cmd: ["scrcpy", "--video-source=camera", "--camera-facing=back", "--camera-size=1920x1080", "--camera-fps=60", "--orientation=180", "--no-audio"] },
        { icon: "󰄁", cmd: ["scrcpy", "--video-source=camera", "--camera-facing=back", "--camera-size=3840x2160", "--camera-fps=30", "--orientation=180", "--no-audio"] },
        { icon: "󱗙", cmd: ["scrcpy", "--video-source=camera", "--camera-facing=front", "--camera-size=1920x1080", "--camera-fps=30", "--orientation=180", "--no-audio"] },
        { icon: "", cmd: ["scrcpy", "--prefer-text"] },
        { icon: "", cmd: ["kitty"] },
        { icon: "󰣇", cmd: ["wofi", "--show", "drun", "-n"] },
        { icon: "", cmd: ["nautilus"] },  // ou supprime complètement ce bouton
        { icon: "", cmd: ["openrgb", "--mode", "static", "--color", "FF0000"] },
        { icon: "", cmd: ["openrgb", "--mode", "static", "--color", "000000"] },
    ]
    

    Repeater {
        model: buttons


        Rectangle {
            id: buttonWidget
            height: buttonSize
            width: buttonSize
            color: buttonHoverHandler.containsMouse ? colors.color1 : colors.color1Dark
            radius: 4

            x: widgetMargin + (index % columnNumber) * (buttonSize + buttonSpacing)
            y: widgetMargin + Math.floor(index / columnNumber) * (buttonSize + buttonSpacing)

            MouseArea {
                id: buttonHoverHandler
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    const p = Qt.createQmlObject(`
                        import Quickshell.Io
                        Process { }
                    `, mainRectangle)

                    p.command = modelData.cmd
                    p.running = true
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 200
                    easing.type: Easing.InOutCubic
                }
            }

            Text {
                anchors.centerIn: parent

                text: modelData.icon

                color: colors.background
                font {
                    pixelSize: buttonSize / 1.5
                    family: "JetBrainsMono Nerd Font"
                }
            }
        }
    }
}