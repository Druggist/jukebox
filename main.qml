import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("JUKEBOX")
    Material.theme: Material.Dark
    Material.accent: "#03A9F4"

    Canvas {
        id: mycanvas
        z: 2
        width: mainWindow.width
        height: mainWindow.height

        property real height_pct: 0.35
        property real width_pct: 0.7

        onPaint: {
            var ctx = getContext("2d");
            ctx.fillStyle = "#03A9F4";
            ctx.beginPath();
            ctx.moveTo(mainWindow.width * width_pct, 0);
            ctx.lineTo(mainWindow.width, 0);
            ctx.lineTo(mainWindow.width,mainWindow.height * height_pct);
            ctx.closePath();
            ctx.shadowColor = "#000000";
            ctx.shadowOffsetX = -2;
            ctx.shadowOffsetY = 2;
            ctx.shadowBlur = 5.0;
            ctx.fill();
        }
    }

    Item {
        z: 1
        width: mainWindow.width
        height: mainWindow.height

        Column {
            width: parent.width * 0.7
            spacing: 50
            padding: 50

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
                width: parent.width
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
}

