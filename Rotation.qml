import QtQuick 2.14
import QtQuick.Controls 2.14

ApplicationWindow {
    visible: true
    width: 400
    height: 300

    Rectangle {
        id: rotatingRect
        width: 200
        height: 150
        color: "orange"
        anchors.centerIn: parent
        rotation: 0  // Initial rotation


        Text {
            id: rotationText
            text: "Rotation: " + rotatingRect.rotation.toFixed(1) + "°"+"₹"
            anchors.centerIn: parent
            font.pointSize: 16
        }
        
        // WheelHandler to rotate
        WheelHandler {
            id: rotateHandler
            target: rotatingRect
            onWheel: {
                var delta = event.angleDelta.y;
                var rotationChange = delta / 10; // Rotation sensitivity
                rotatingRect.rotation += rotationChange;
                rotationText.text = "Rotation: " + rotatingRect.rotation.toFixed(1) + "°"+"₹";
            }
        }
    }
}
