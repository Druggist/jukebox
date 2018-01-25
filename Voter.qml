import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    property int votes_total: jukebox.get_total_votes();
    property string song : jukebox.get_vote_title(model.index);
    property int votes: jukebox.get_vote_count(model.index);
    property int index: jukebox.get_vote_index(model.index);

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
            value: (votes * 1.0)/votes_total
            width: {
                width: 250
                if(title.width > 250)
                    width: title.width
            }
        }

        Label {
            id: votes_count
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

        onClicked: jukebox.vote(index);
    }

    Connections {
        target: jukebox
        onUpdateVoters: {
            votes_total = jukebox.get_total_votes();
            votes = jukebox.get_vote_count(model.index);
            progBar.value = (votes * 1.0)/votes_total
            votes_count.text = votes + "/" + votes_total
        }

        onDisableVoters: {
            vote.visible = false
        }
    }
}
