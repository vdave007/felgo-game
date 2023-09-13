import QtQuick 2.0

Image {
    id: root
    property bool toggled: false

    signal clicked
    source: toggled ? Qt.resolvedUrl("../../assets/img/toggle-on.png"): Qt.resolvedUrl("../../assets/img/toggle-off.png")

    MouseArea {
        anchors.fill: parent

        onClicked: root.clicked()
    }

}
