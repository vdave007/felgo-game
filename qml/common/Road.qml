import QtQuick 2.0

Item {
    id: root

    Image {
        id: road
        source: Qt.resolvedUrl("../../assets/img/road3.png")
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
        }

        fillMode: Image.TileHorizontally
    }

    SpeedSign {
        speedLimit: gameState.speedLimit
        width: 32
        height: 32
        anchors {
            left: road.left
            top: road.top
        }
    }

    height: 162

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

}
