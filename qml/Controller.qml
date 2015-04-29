import QtQuick 2.0
import "sesssave.js" as StateSave

Item {
  property bool enabled: false
  property bool continuous: false
  property bool repeat: true
  property real sampleRate: session.devices.length ? session.devices[0].DefaultRate : 0
  property real sampleTime: 0.1
  readonly property int sampleCount: sampleTime * sampleRate

  function trigger() {
    session.sampleRate = sampleRate
    session.sampleCount = sampleCount
    session.start(continuous);
    if ( session.devices.length > 0 ) {
      lastConfig = StateSave.saveState();
    }
  }

  Timer {
    id: timer
    interval: 100
    onTriggered: { trigger() }
  }

  function toggle() {
    if (!enabled) {
      trigger();
      enabled = true;
    } else {
      enabled = false;
      if (continuous || sampleTime > 0.1) {
        session.cancel();
      }
    }
  }

  Connections {
    target: session
    onFinished: {
      if (!continuous && repeat && enabled) {
        timer.start();
      }
    }

    onDetached: {
      enabled = false;
      continuous = false;
    }
  }
}
