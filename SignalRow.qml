import QtQuick 2.1
import QtQuick.Layouts 1.0
import Plot 1.0

RowLayout {
  Layout.fillHeight: true
  property var xaxis
  property var signal

  Rectangle {
    width: 320
    Layout.fillHeight: true
    color: '#444444'

    Text {
      color: 'white'
      text: signal.label
    }
  }

  PhosphorRender {
      Layout.fillHeight: true
      Layout.fillWidth: true

      id: line
      anchors.margins: 20

      buffer: signal.buffer

      pointSize: Math.max(2, Math.min(xaxis.xscale/session.sampleRate*3, 20))

      xmin: xaxis.visibleMin
      xmax: xaxis.visibleMax
      ymin: signal.min
      ymax: signal.max
  }
}
