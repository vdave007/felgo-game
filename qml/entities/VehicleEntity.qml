import QtQuick
import Felgo 4.0
import "../common"

EntityBase {
    id: vehicle
    width: 50
    height: 30

    entityId: "vehicleId"
    entityType: "Vehicle"

    readonly property int finalSpeed: velocity * speedModifier

    property bool animationRunning: true
    property int velocity: 100
    property real speedModifier: 1
    property GameState gameState
    signal exitedFromScene

    Rectangle {
        id: vehicleAsset
        anchors.fill: parent
        color: "red"

        Column  {
            anchors.centerIn: parent
            Text {
                font.pixelSize: 7
                visible: debugInfoEnabled
                text: vehicle.entityId
            }
            Text {
                font.pixelSize: 7
                visible: debugInfoEnabled
                text: "speed:" + vehicle.finalSpeed
            }

        }

        MouseArea {
            anchors.fill: parent
            enabled: gameState.sirenRunning
            onClicked: {
                if (movement.running) {
                    console.log("Stopping vehicle:", entityId);
                    movement.stop()
                    vehicle.x = 350
                    vehicle.y = 128;
                    vehicle.entityType = "StoppedVehicle"
                } else {
                    movement.start();
                    vehicle.y = 83;
                    vehicle.velocity = 30;
                    vehicle.entityType = "Vehicle"
                }
            }
        }
    }

    BoxCollider {
        // the BoxCollider will not be affected by gravity or other applied physics forces
        collisionTestingOnlyMode: true

        anchors.centerIn: vehicle
        width: vehicle.width + 10
        height: vehicle.height + 10

        fixture.onBeginContact: {
            var body = other.getBody();
            var collidedEntity = body.target;
            var collidedEntityType = collidedEntity.entityType;
            var collidedEntityId = collidedEntity.entityId;

            if (collidedEntityType == vehicle.entityType) {
                vehicleAsset.color = "#abcdef";
                let smallerSpeed = Math.min(vehicle.velocity, collidedEntity.velocity);
                vehicle.velocity = smallerSpeed;
                collidedEntity.velocity = smallerSpeed;

            }
        }
    }

    MovementAnimation {
        id: movement
        target: vehicle
        property: "x"
        minPropertyValue: 0
        maxPropertyValue: 480
        velocity: vehicle.finalSpeed
        running: vehicle.animationRunning
        onLimitReached: {
            animationRunning = false;
            vehicle.removeEntity();
        }
    }

}
