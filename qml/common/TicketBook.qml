import QtQuick 2.0
import QtQuick.Controls 2.12

Popup {
    id: popup
    anchors.centerIn: parent
    width: 200
    height: 300
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    contentItem: Item {
        Text {
            text: "Ticket reason:"
        }
    }

    background: Rectangle {
        color: "pink"
    }
}
