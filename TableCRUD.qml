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
        height: parent.height - 150
        anchors.top: parent.top

        model: tableModel

        TableViewColumn {
            title: "Name"
            role: "name"
            width: 200
        }

        TableViewColumn {
            title: "Age"
            role: "age"
            width: 100
        }
    }

    Column {
        spacing: 10
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        // Add Row Section
        Row {
            spacing: 10

            TextField {
                id: newNameField
                placeholderText: "Name"
                width: 150
            }

            TextField {
                id: newAgeField
                placeholderText: "Age"
                width: 100
                inputMethodHints: Qt.ImhDigitsOnly
            }

            Button {
                text: "Add Row"
                onClicked: {
                    var name = newNameField.text;
                    var age = parseInt(newAgeField.text);
                    if (name && !isNaN(age)) {
                        tableModel.append({ name: name, age: age });
                        newNameField.text = "";
                        newAgeField.text = "";
                    }
                }
            }
        }

        // Update Row Section
        Row {
            spacing: 10

            TextField {
                id: updateIndexField
                placeholderText: "Row Index"
                width: 100
                inputMethodHints: Qt.ImhDigitsOnly
            }

            TextField {
                id: updateNameField
                placeholderText: "New Name"
                width: 150
            }

            TextField {
                id: updateAgeField
                placeholderText: "New Age"
                width: 100
                inputMethodHints: Qt.ImhDigitsOnly
            }

            Button {
                text: "Update Row"
                onClicked: {
                    var index = parseInt(updateIndexField.text);
                    var newName = updateNameField.text;
                    var newAge = parseInt(updateAgeField.text);
                    if (index >= 0 && index < tableModel.count && newName && !isNaN(newAge)) {
                        tableModel.set(index, { name: newName, age: newAge });
                    }
                }
            }
        }

        // Remove Row Section
        Row {
            spacing: 10

            TextField {
                id: removeIndexField
                placeholderText: "Row Index"
                width: 100
                inputMethodHints: Qt.ImhDigitsOnly
            }

            Button {
                text: "Remove Row"
                onClicked: {
                    var index = parseInt(removeIndexField.text);
                    if (index >= 0 && index < tableModel.count) {
                        tableModel.remove(index);
                    }
                }
            }
        }
    }
}
