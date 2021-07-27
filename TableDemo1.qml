import QtQuick 2.12
import QtQuick.Window 2.12
import Qt.labs.qmlmodels 1.0
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick 2.2
import QtQuick.Controls 1.2
Window{

        width:800
        height :600
        Rectangle{
                width:parent.width
                height:parent.height
                color: "#333333"
                id: root


            ListModel {
                id: live_alertmodel

            }

            TableView {
               // anchors.top: download_bt.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width
                height: 300

                TableViewColumn {
                    role: "time"
                    title: "Time"
                    width: root.width/5
                    delegate:textDelegate
                }
                TableViewColumn {
                    role: "location"
                    title: "Location"
                    width: root.width/5
                    delegate:textDelegate
                }

                TableViewColumn {
                    role: "alert"
                    title: "Alert"
                    width: root.width/5
                    delegate:textDelegate
                }

                TableViewColumn {
                    role: "image"
                    title: "Image"
                    width: root.width/5
                    delegate:imageDelegate

                }

                TableViewColumn {
                    role: "shape"
                    title: "Shape"
                    width: root.width/5
                    delegate:shapeDelegate

                }
                model: live_alertmodel



                Component  {
                                id: textDelegate
                                Item {
                                    id: f_item
                                    height: cell_txt.height
                                    Text {
                                        id: cell_txt
                                        width: parent.width
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        //font.bold: true
                                        text: styleData.value
                                        elide: Text.AlignHCenter
                                        color: "black"
                                        renderType: Text.NativeRendering
                                    }
                                }
                            }



                Component {

                    id: shapeDelegate
                            Item {

                            //clip: true
                            anchors.centerIn: parent
                            Rectangle {
                                           border.width: 1
                                           border.color:styleData.selected?"blue":"lightgray"
                                     }
                            }
                         }


                Component {
                    id: imageDelegate
                    Item {
                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            fillMode: Image.PreserveAspectFit
                            height:20
                            cache : true;
                            asynchronous: true;
                            source: styleData.value// !== undefined  ? styleData.value : ""
                        }
                    }
                 }









                Component.onCompleted: {
                    for(var i=0;i<10;i++)
                      live_alertmodel.append({ time:"07/23/2015",
                                      location:"location",
                                      alert:"access",
                                      image:"http://images.freeimages.com/images/premium/previews/4852/48521810-globe-icon-flat-icon-with-long-shadow.jpg"


                                             })
                }
            }
      }




}
