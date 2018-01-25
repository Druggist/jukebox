import QtQuick 2.0
Grid {
    columns: 2
    spacing: 50
    columnSpacing: 150

    Repeater{
        model:jukebox.get_votes_length();

        Voter{
        }
    }
}
