import QtQuick 2.14
import Qt.labs.qmlmodels 1.0

Rectangle {
    width: 800
    height: 400   // Increased height to allow more vertical space

    PathView {
        id: pathView
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        model: ListModel {
            ListElement { category: "Fruits"; color: "red" }
            ListElement { category: "Vegetables"; color: "green" }
            ListElement { category: "Dairy"; color: "blue" }
            ListElement { category: "Fruits"; color: "orange" }
            ListElement { category: "Vegetables"; color: "lightgreen" }
            ListElement { category: "Dairy"; color: "lightblue" }
        }

        delegate: Item {
            width: 100
            height: 100
            Rectangle {
                width: 100
                height: 100
                color: model.color
                border.color: "black"
                border.width: 2
                Text {
                    anchors.centerIn: parent
                    text: model.category
                    color: "white"
                    font.bold: true
                }
            }
        }

        path: Path {
            startX: 50
            startY: 100  // Adjust the startY to shift the starting point downwards

            // Modify the PathQuad to increase vertical spread
            PathQuad {
                x: 500
                y: 300    // Increase y to spread the items more vertically towards the end
                controlX: 400
                controlY: 50    // Adjust the control point to modify the curve height
            }
        }

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            pathView.incrementCurrentIndex()
        }
    }
}
