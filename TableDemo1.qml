import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls 1.4
import Qt.labs.folderlistmodel 2.12

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    TableView {
        width: parent.width
        height: parent.height

        model: ListModel {
            id: tableModel
            // Initial empty, data will be filled from the text file
        }

        TableViewColumn {
            title: "Name"
            role: "name"
            width: 150
        }

        TableViewColumn {
            title: "Age"
            role: "age"
            width: 100
        }
    }

    Component.onCompleted: {
        // Call the function to load data from the text file
        loadDataFromFile("./data.txt")
    }

    function loadDataFromFile(filename) {
        var file = Qt.createQmlObject('import QtQuick 2.0; QtObject {}', tableModel);
        var url = Qt.resolvedUrl(filename);

        // Load the file and process data
        var xhr = new XMLHttpRequest();
        xhr.open("GET", url);
        console.log("",url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    // Process file contents (assuming data is in CSV format)
                    var lines = xhr.responseText.split("\n");
                    for (var i = 0; i < lines.length; i++) {
                        var fields = lines[i].split(",");
                        if (fields.length === 2) {
                            tableModel.append({
                                name: fields[0].trim(),
                                age: parseInt(fields[1].trim())
                            });
                        }
                    }
                } else {
                    console.log("Error loading file");
                }
            }
        }
        xhr.send();
    }
}
