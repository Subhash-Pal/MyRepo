import QtQuick 2.14
import QtQuick.Controls 2.14

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Dynamic Component Example"

    // Define a component that can be dynamically created
    Component {
        id: dynamicRectangle

        Rectangle {
            width: 100
            height: 100
            color: "lightblue"
            border.color: "darkblue"
            border.width: 2
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "I'm dynamic!"
                color: "black"
            }
        }
    }

    // Area where the dynamic components will be loaded
    Loader {
        id: loader
        anchors.centerIn: parent
    }

    Button {
        text: "Create Rectangle"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20

        onClicked: {
            loader.sourceComponent = dynamicRectangle;
        }
    }
}
