import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    id: player
    height: 50

    Column {
        spacing: 5

        Label {
            id: title
            text: jukebox.getSong();
        }
        Row {
            spacing: 5

            Label {
                id: elapsed
                text: jukebox.getElapsedTime();
                anchors.verticalCenter: prog.verticalCenter
            }

            Slider {
                id: prog
                value: jukebox.getPlayerVal();
                width:  player.width
                enabled : false
            }


            Label {
                id: song_duration
                text: jukebox.getTotalTime();
                anchors.verticalCenter: prog.verticalCenter
            }
        }
    }

    Connections {
        target: jukebox
        onUpdatePlayer: {
            elapsed.text = jukebox.getElapsedTime();
            song_duration.text = jukebox.getTotalTime();
            title.text = jukebox.getSong();
            prog.value = jukebox.getPlayerVal();
        }
    }
}
