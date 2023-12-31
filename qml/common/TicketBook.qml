import QtQuick 2.0
import QtQuick.Controls 2.12

Popup {
    id: popup

    property GameState gameState

    property string reason: gameState.lastValidMeasurement > 0 ? "SPEEDING" : "No reason"

    anchors.centerIn: parent
    width: 200
    height: 300
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    contentItem: Item {
        Column {
            spacing: 10
            width: 180
            anchors {
                left: parent.left
                leftMargin: 10
            }

            StyledText {
                width: parent.width

                text: `Ticket reason: ${reason}`
            }

            StyledText {
                width: parent.width
                visible: gameState.lastValidMeasurement > 0

                text: `Issued to: ${gameState.lastValidMeasurmentVehicleId}`
            }

            StyledText {
                width: parent.width
                visible: gameState.lastValidMeasurement > 0

                text: `Speed: ${gameState.lastValidMeasurement}`
            }
        }

        MenuButton {
            text: "Give ticket"
            visible: gameState.hasStoppedCar
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            onClicked: {
                gameState.issueTicket(gameState.stoppedCar);
                popup.close()
            }
        }
    }

    background: Image {
        width: popup.width
        height: popup.height
        source: Qt.resolvedUrl("../../assets/img/ticket-big.png")
    }
}
