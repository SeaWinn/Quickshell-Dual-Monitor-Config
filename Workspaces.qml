import Quickshell
import Quickshell.Hyprland
import QtQuick


Rectangle {
    property var colors

    id: rowBackground
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    
    width: workspaceRow.width + 12
    height: workspaceRow.height + 6
    
    color: colors.background
    topLeftRadius: 10
    topRightRadius: 10
    bottomLeftRadius: 0
    bottomRightRadius: 0
    Row {
        id: workspaceRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: 3
        Repeater {
            model: 10
        
            Item {
                width: (index === 4) ? 50 + 6 : 50 
                height: 8
                anchors.bottom: parent.bottom
                Rectangle {
                    id: workspaceRect
                    width: 50
                    height: parent.height
                    topLeftRadius: 5
                    topRightRadius: 5
                    bottomLeftRadius: 0
                    bottomRightRadius: 0
                    color: (index + 1 === Hyprland.focusedWorkspace.id) ? colors.color1Light : colors.color1Dark
                    MouseArea {
                    anchors.fill: parent

                    onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${index + 1}})`)
                    }
                }
            }
        }
    }
}
