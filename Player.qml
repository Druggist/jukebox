import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    property double duration: 0
    property double start_time: 0
    property string song : ""

    id: player
    height: 50

    Column {
        spacing: 5

        Label {
            id: title
            text: song
        }
        Row {
            spacing: 5

            Label {
                text: start_time
                anchors.verticalCenter: prog.verticalCenter
            }

            Slider {
                id: prog
                value: start_time
                width:  player.width
                from: 0.0
                to: duration
                enabled : false
            }


            Label {
                text: duration.toString()
                anchors.verticalCenter: prog.verticalCenter
            }
        }
    }
}
