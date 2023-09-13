import QtQuick 2.0

Image {
    id: root

    source: Qt.resolvedUrl("../../assets/img/car-paper.png")

    signal clicked

    MouseArea {
        anchors.fill: parent

        onClicked: {
            root.clicked();
        }
    }
}
