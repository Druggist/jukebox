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

    Loader{
        id: mainLoader
        source: 'ConnectView.qml'
        asynchronous: true

        function reload(){
            source = '';
            source = 'MainView.qml';
        }

        Connections {
            target: jukebox
            onConnectSuccess: {
                mainLoader.reload();
            }
        }
    }
}

