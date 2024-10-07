import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Rectangle {
    width: 400
    height: 600

    XmlListModel {
        id: rssModel
        source: "https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"
        query: "/rss/channel/item"
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "link"; query: "link/string()" }
    }

    ListView {
        anchors.fill: parent
        model: rssModel
        delegate: Text {
            text: title
            font.pixelSize: 16

        }
    }
}

