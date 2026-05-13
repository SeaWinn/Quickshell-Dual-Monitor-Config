import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "file:/home/louka/.cache/wal/"

ShellRoot {

  Colors { id: pywal }
  
  Variants {
    
    model: Quickshell.screens

    PanelWindow {
      id: bar

      property var modelData
      screen: modelData

      //WlrLayershell.layer: WlrLayer.Overlay
      //exclusionMode: WlrLayer.Overlay

      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "shell:background"
      
      mask: Region { item:dateWidget }

      anchors {
        bottom: true
        left: true
        right: true
      }
      implicitHeight: 1080
      color: "transparent"

      DateWidget {
        id: dateWidget
        colors: pywal
      }

      Rectangle {
        id: rowBackground
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        
        width: workspaceRow.width + 12
        height: workspaceRow.height + 6
        
        color: pywal.background
        topLeftRadius: 5
        topRightRadius: 5
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
                color: (index + 1 === Hyprland.focusedWorkspace.id) ? pywal.color1Light : pywal.color1Dark

                MouseArea {
                  anchors.fill: parent
                  onClicked: Hyprland.dispatch(`workspace ${index + 1}`)
                }
              }
            }
          }
        }
      }
    }
  }
}