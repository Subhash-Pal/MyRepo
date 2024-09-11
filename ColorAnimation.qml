import QtQuick 2.0

Rectangle {
    width: 400
    height: 300
    color: "lightgray"

    Rectangle {
        id: colorRect
        width: 100
        height: 100
        color: "red"
        anchors.centerIn: parent

        // ColorAnimation to change the color of the rectangle
        ColorAnimation {
            id: colorChange
            target: colorRect
            property: "color"
            from: "red"
            to: "green"
            duration: 1000
        }

        // MouseArea to trigger the color change when clicked
        MouseArea {
            anchors.fill: parent
            onClicked: {
                colorChange.start();
            }
        }
    }
}
