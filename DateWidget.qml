import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
  id: root
  property var colors 

  topLeftRadius: 5
  topRightRadius: 5
  bottomLeftRadius: 0
  bottomRightRadius: 0

  implicitHeight: hoverHandler.containsMouse? 50 : 20
  implicitWidth: 100
  color: colors.background

  MouseArea {
    id: hoverHandler
    anchors.fill: parent
    hoverEnabled: true
  }

  Behavior on implicitHeight {
      NumberAnimation {
        duration: 250
        easing.type: Easing.InOutCubic
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Column {
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 3
    spacing: 3

    Text {
      id: clock
      anchors.horizontalCenter: parent.horizontalCenter

      font {
          pixelSize: 14
          bold: true
      }

      color: colors.color1
      
      Process {
        id: clockProcess

        command: ["sh", "-c", "date +\"%H:%M:%S\""]
        running: true

        stdout: StdioCollector {
          onStreamFinished: clock.text = this.text
        }
      }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        
        implicitWidth: root.width / 1.25
        implicitHeight: 2
        radius: 100

        color: colors.color1
    }

    Text {
      id: date
      anchors.horizontalCenter: parent.horizontalCenter

      width: parent.width // makes the text width the same as the parent to then align the text 
      horizontalAlignment: Text.AlignHCenter

      font {
        pixelSize: 14
        bold: true
      }

      color: colors.color2

      Process {
        id: dateProcess

        command: ["sh", "-c", "LC_TIME=fr_FR.UTF-8 date '+%a %d %b'"]
        running: true

        stdout: StdioCollector {
          onStreamFinished: date.text = this.text
        }
      }
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      dateProcess.running = true
      clockProcess.running = true
    }
  }
}