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
            text: jukebox.get_song();
        }
        Row {
            spacing: 5

            Label {
                id: elapsed
                text: jukebox.get_elapsed_time();
                anchors.verticalCenter: prog.verticalCenter
            }

            Slider {
                id: prog
                value: jukebox.get_player_val();
                width:  player.width
                enabled : false
            }


            Label {
                id: song_duration
                text: jukebox.get_total_time();
                anchors.verticalCenter: prog.verticalCenter
            }
        }
    }

    Connections {
        target: jukebox
        onUpdatePlayer: {
            elapsed.text = jukebox.get_elapsed_time();
            song_duration.text = jukebox.get_total_time();
            title.text = jukebox.get_song();
            prog.value = jukebox.get_player_val();
        }
    }
}
