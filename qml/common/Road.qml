import QtQuick 2.0

Item {

    property int lanes: 1

    Image {
        source: Qt.resolvedUrl("../../assets/img/road3.png")
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
        }

        fillMode: Image.TileHorizontally
    }

    height: 162

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

}
