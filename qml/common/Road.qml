import QtQuick 2.0

Image {
    id: root
    height: 162
    source: Qt.resolvedUrl("../../assets/img/road3.png")
    anchors {
        left: parent.left
        top: parent.top
        right: parent.right
    }

    fillMode: Image.TileHorizontally

    SpeedSign {
        speedLimit: gameState.speedLimit
        width: 32
        height: 32
        anchors {
            left: root.left
            top: root.top
        }
    }
}
