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

    Column {
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
                start_time: 5.02
                duration: 10.12
                song: "Klocuch - Kruci Gang"
                width: parent.width
            }
        }

        Grid {
            columns: 2
            spacing: 50
            columnSpacing: parent.width * 0.1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter

            Voter {
                song: "Bracia Pierdolec SANFRANCISCO"
                votes: 15
                votes_total: 20
            }
            Voter {
                song: "Bracia Pierdolec "
                votes: 15
                votes_total: 20
            }
            Voter {
                song: "Bracia Pierdolec SANFRANCISCO"
                votes: 15
                votes_total: 20
            }
            Voter {
                song: "Bracia Pierdolec SANFRANCISCO"
                votes: 15
                votes_total: 20
            }
            Voter {
                song: "Bracia Pierdolec SANFRANCISCO"
                votes: 15
                votes_total: 20
            }
            Voter {
                song: "Bracia Pierdolec SANFRANCISCO"
                votes: 15
                votes_total: 20
            }
            Voter {
                song: "Bracia Pierdolec SANFRANCISCO"
                votes: 15
                votes_total: 20
            }
            Voter {
                song: "Bracia Pierdolec SANFRANCISCO"
                votes: 15
                votes_total: 20
            }
        }
    }
}

