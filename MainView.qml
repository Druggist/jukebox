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

        Player {
            id: player
            width: parent.width - 100
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Loader{
        id: votersLoad
        source: 'VotersGenerator.qml'
        asynchronous: true

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        function reload(){
            source = '';
            source = 'VotersGenerator.qml';
        }

        Connections {
            target: jukebox
            onResetVoters: {
                votersLoad.reload();
            }
        }
    }
}
