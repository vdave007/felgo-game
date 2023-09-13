import QtQuick 2.0

Image {
    id: root
    property int speedLimit: 0

    signal clicked
    source: Qt.resolvedUrl("../../assets/img/speedsign.png")

    StyledText {
        anchors.centerIn: parent
        font.pixelSize: 12
        text: root.speedLimit
    }

}
