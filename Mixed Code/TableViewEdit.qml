import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    ListModel {
        id: tableModel
        ListElement { name: "John"; age: 30 }
        ListElement { name: "Jane"; age: 25 }
        ListElement { name: "Jack"; age: 35 }
    }

    TableView {
        width: parent.width
        height: parent.height - 100
        anchors.top: parent.top

        model: tableModel

        TableViewColumn {
            title: "Name"
            role: "name"
            width: 200
            delegate: Item {
                width: 200
                height: 40
                property bool editing: false

                // Display the value
                Text {
                    text: model.name
                    anchors.fill: parent
                    visible: !editing
                    anchors.centerIn: parent
                }

                // TextField for editing
                TextField {
                    text: model.name
                    anchors.fill: parent
                    visible: editing
                    anchors.centerIn: parent
                    onEditingFinished: {
                        model.name = text;
                        editing = false;
                    }
                    focus: editing
                }

                MouseArea {
                    anchors.fill: parent
                    onDoubleClicked: {
                        editing = true;
                        textField.forceActiveFocus();
                    }
                }
            }
        }

        TableViewColumn {
            title: "Age"
            role: "age"
            width: 100
            delegate: Item {
                width: 100
                height: 40
                property bool editing: false

                // Display the value
                Text {
                    text: model.age
                    anchors.fill: parent
                    visible: !editing
                    anchors.centerIn: parent
                }

                // TextField for editing
                TextField {
                    id: textField
                    text: model.age
                    anchors.fill: parent
                    visible: editing
                    anchors.centerIn: parent
                    inputMethodHints: Qt.ImhDigitsOnly
                    onEditingFinished: {
                        model.age = parseInt(text);
                        editing = false;
                    }
                    focus: editing
                }

                MouseArea {
                    anchors.fill: parent
                    onDoubleClicked: {
                        editing = true;
                        textField.forceActiveFocus();
                    }
                }
            }
        }
    }

    Button {
        text: "Add Row"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        onClicked: {
            tableModel.append({ name: "New Name", age: 0 });
        }
    }

    Button {
        text: "Remove Row"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 100
        onClicked: {
            if (tableModel.count > 0) {
                tableModel.remove(0);
            }
        }
    }
}
