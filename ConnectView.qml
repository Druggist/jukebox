import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    z: 1
    width: mainWindow.width
    height: mainWindow.height

    Column {
        width: parent.width * 0.7
        spacing: 50

        Item {
            id: mainTitle
            width: parent.width
            height: 100

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "JUKEBOX"
                color: "#03A9F4"
                font.pixelSize: 32
                font.bold: true
            }
        }
    }

    Item {
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -100

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: - (server_ip.width + connect.width + 20) / 2

            Label {
                id: ip_label
                text: "Server IP:"
            }
            Row {
                id: server_row
                anchors.top: ip_label.bottom

                TextField {
                    id: server_ip
                    width: 180
                    height: 50
                    inputMask: "000.000.000.000;"
                    horizontalAlignment: TextInput.AlignHCenter
                }

                Button {
                    id: connect
                    text: "Connect"
                    anchors.left: server_ip.right
                    anchors.leftMargin: 20

                    onClicked: jukebox.connectToServer(server_ip.text);
                }
            }

            Label {
                id: error_label
                text: " "
                color: "#f44336"
                font.bold: true
                font.pointSize: 18

                anchors.top: server_row.bottom
                anchors.topMargin: 100
            }
        }

        Connections {
            target: jukebox
            onConnectFail: {
                error_label.text = "IP you passed is wrong"
            }
        }
    }
}
