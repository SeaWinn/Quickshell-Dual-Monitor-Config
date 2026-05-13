import Quickshell
import Quickshell.Wayland
import QtQuick
import "file:/home/louka/.cache/wal/"

ShellRoot {

  Colors { id: pywal }
  
  Variants {
    
    model: Quickshell.screens

    PanelWindow {
      property var modelData
      screen: modelData

      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "shell:background"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    

      id: bar
      
      mask: Region { // Pick which items are clickable/hoverable
        regions: [
          Region { item: dateWidget },
          Region { item: workspaceRow }
        ]
      }

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: 1080
      color: "transparent"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      DateWidget {
        id: dateWidget
        colors: pywal

        anchors {
          bottom: parent.bottom
          left: parent.left
          leftMargin: workspacesWidget.width
        }
      }

      Workspaces{
        id: workspacesWidget
        colors: pywal
      }
    }
  }
}
