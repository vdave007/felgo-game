import QtQuick 2.0

Image {
    id: root

    source: Qt.resolvedUrl("../../assets/img/ticket-book.png")

    signal clicked

    MouseArea {
        anchors.fill: parent

        onClicked: {
            root.clicked();
        }
    }
}
