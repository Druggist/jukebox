import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    property double votes_total: 1
    property string song : ""
    property double votes: 0

    height: 50
    width: prog.width + vote.width + 20

    Column {
        id: prog
        spacing: 5

        Label {
            id: title
            text: song
        }

        ProgressBar {
            id: progBar
            value: votes/votes_total
            width: {
                width: 250
                if(title.width > 250)
                    width: title.width
            }
        }

        Label {
            text: votes + "/" + votes_total
            horizontalAlignment: Text.AlignHCenter
            anchors.left: progBar.left
            anchors.right: progBar.right
        }


    }

    Button {
        id: vote
        anchors.left: prog.right
        anchors.leftMargin: 20
        text: "Vote"
    }
}
