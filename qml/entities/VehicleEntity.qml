import QtQuick
import Felgo 4.0
import "../common"

EntityBase {
    id: vehicle
    width: 50
    height: 30

    entityId: "vehicleId"
    entityType: "Vehicle"

    readonly property int finalSpeed: {
        let tempSpeed = velocity * speedModifier;
        if(!ignoresSiren) {
            if (gameState.sirenRunning){
                tempSpeed = tempSpeed * upgradeManager.sirenModifier;
            }
        }
        return tempSpeed;
    }

    property bool animationRunning: true
    property int velocity: 100
    property real speedModifier: 1

    property string licensePlate: entityId
    property int maxSpeed: 30
    property string type: "unknown"
    property string model: "unknown"
    property bool ignoresSiren: false
    property url assetPath: Qt.resolvedUrl("../../assets/cars/"+model+".png")

    property GameState gameState
    property UpgradeManager upgradeManager

    Image {
        id: vehicleAsset
        anchors.fill: parent
        rotation: 180
        source: assetPath

        Column  {
            rotation: 180
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
                if(!gameState.hasStoppedCar){
                    if (movement.running) {
                        console.log("Stopping vehicle:", entityId);
                        movement.stop()
                        vehicle.x = 200;
                        vehicle.y = 128;
                        vehicle.entityType = "StoppedVehicle"
                        gameState.carStopped(vehicle)
                    }
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

    Connections {
        target: gameState

        onCarReleased: {
            if(car == vehicle) {
                movement.start();
                vehicle.y = 83;
                vehicle.velocity = 30;
                vehicle.entityType = "Vehicle"
            }
        }
    }

}
