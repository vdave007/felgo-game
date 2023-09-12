import QtQuick 2.0

Item {

    property int lanes: 1

    Image {
        source: Qt.resolvedUrl("../../assets/bg/road.png")
        anchors.fill: parent
    }

    height: 200

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

}
