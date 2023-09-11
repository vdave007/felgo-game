import QtQuick
import Felgo

EntityBase {
    id: vehicle
    width: 50
    height: 30

    entityId: "vehicleId"
    entityType: "Vehicle"

    property bool animationRunning: true
    property int velocity: 100
    signal exitedFromScene

    Rectangle {
        id: vehicleAsset
        anchors.fill: parent
        color: "red"

        Text {
            anchors.centerIn: parent
            text: vehicle.entityId
        }
    }

    BoxCollider {
        // the BoxCollider will not be affected by gravity or other applied physics forces
        collisionTestingOnlyMode: true

        anchors.centerIn: vehicle
        width: vehicle.width + 10
        height: vehicle.height + 10

        fixture.onBeginContact: {

            console.log("IN");

            var body = other.getBody();
            var collidedEntity = body.target;
            var collidedEntityType = collidedEntity.entityType;
            var collidedEntityId = collidedEntity.entityId;

            if (collidedEntityType == vehicle.entityType) {
                vehicleAsset.color = "#000000";
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
        velocity: vehicle.velocity
        running: vehicle.animationRunning
        onLimitReached: {
            animationRunning = false;
            vehicle.removeEntity();
        }
    }

}
