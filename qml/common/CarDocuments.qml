import QtQuick 2.0
import QtQuick.Controls 2.12

Popup {
    id: popup

    property GameState gameState
    property var vehicle

    anchors.centerIn: parent
    width: 350
    height: 500
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    contentItem: Item {

        Column {
            spacing: 20
            width: 310
            anchors {
                left: parent.left
                leftMargin: 10
            }

            StyledText {
                width: parent.width
                text: `License plate: ${vehicle.licensePlate}`
            }
            StyledText {
                width: parent.width
                text: `Car model: ${vehicle.model}`
            }
            StyledText {
                width: parent.width
                text: `Car type: ${vehicle.type}`
            }
            MenuButton {
                text: "Give back and release"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                onClicked: {
                    gameState.carReleased(vehicle);
                }
            }
        }

    }

    background: Image {
        width: popup.width
        height: popup.height
        source: Qt.resolvedUrl("../../assets/img/car-paper-open-big.png")
    }
}
