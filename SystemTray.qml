import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts



Rectangle{

    width: trayRow.width + 10
    height: trayRow.height + 10

    topLeftRadius: 10
    topRightRadius: 10
    bottomLeftRadius: 0
    bottomRightRadius: 0
    
    color: pywal.background

    Row {
        id: trayRow
        spacing: 5
        anchors.centerIn: parent

        Repeater {
            model: SystemTray.items
            delegate: IconImage {
                id: trayIcon
                source: modelData.icon
                width: 18
                height: 18

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    
                    onClicked: (mouse) => {
                        if (mouse.button === Qt.LeftButton) {
                            modelData.activate()
                        } 
                        else if (mouse.button === Qt.RightButton) {
                            var coords = trayIcon.mapToItem(bar.contentItem, mouse.x, mouse.y)
                            modelData.display(bar, coords.x, coords.y)
                        }
                    }
                }
            }
        }
    }
}