import QtQuick 2.0
import QtQuick.Controls.Styles 1.1

SliderStyle {
    groove: Rectangle {
        implicitWidth: 200
        implicitHeight: 8
        gradient: Gradient {
            GradientStop { position: 1.0; color: Qt.rgba(1,1,1,0.08)}
            GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.0)}
        }
        radius: 8
    }
    handle: Rectangle {

        color: control.pressed ? "#858484" : "#4E4E4E"
        border.color: "#4E4E4E"
        border.width: 2
        width: 20
        height: 20
        radius: 8
    }
}
