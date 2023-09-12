import QtQuick
import Felgo

EntityBase {
    id: root

    entityId: "entity"
    entityType: "SpeedGun"

    property var targetedVehicle: undefined

    Rectangle {
        id: pointer
        color: "red"

        height: 5
        width: 5
        radius: 20

        anchors {
            bottom: display.top
            horizontalCenter: display.horizontalCenter
        }
    }

    Rectangle {
        id: display
        width: 50
        height: 50
        opacity: 1
        color: "transparent"

        anchors {
            bottom: handle.top
            horizontalCenter: handle.horizontalCenter
        }

        border.color: 'black'
        border.width: 10

        Text {
            anchors.centerIn: display
            text: !targetedVehicle ? "-" : targetedVehicle.velocity
        }
    }

    Rectangle {
        id: handle
        color: "black"
        width: 20
        height: 30
        anchors {
            bottom: root.bottom
            horizontalCenter: root.horizontalCenter
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag {
                target: root
                axis: Drag.XandYAxis
            }
        }
    }

    BoxCollider {
        anchors.fill: pointer
        collisionTestingOnlyMode: true

        property int colliderCounter: 0

        fixture.onBeginContact: {
            var body = other.getBody();
            targetedVehicle = body.target;
            colliderCounter++;
        }

        fixture.onEndContact: {
            colliderCounter--;
            if (colliderCounter == 0) {
                targetedVehicle = undefined;
            }
        }

    }

}
