import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
  id: root
  property var colors 

  anchors {
    bottom: parent.bottom
    left: parent.left
    leftMargin: rowBackground.width
  }

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
        duration: 400
        easing.type: Easing.InOutCubic
    }
  }

  Text {
    id: clock
    anchors.centerIn: parent

    font {
        pixelSize: 14
        bold: true
    }

    color: colors.color1Light

    Process {
      id: dateProcess

      command: ["sh", "-c", "date +\"%H:%M:%S\""]
      running: true

      stdout: StdioCollector {
        onStreamFinished: clock.text = this.text
      }
    }
  Timer {
    interval: 1000

    running: true

    repeat: true

    onTriggered: dateProcess.running = true
  }
  }
}