import QtQuick
import Felgo 4.0
import "../common"

EntityBase {
    id: speedGunBase

    entityId: "entity"
    entityType: "SpeedGun"

    property GameState gameState
    property UpgradeManager upgradeManager

    property var targetedVehicle: undefined
    property int timeToFixate: 3000 * (1 - upgradeManager.speedGunUpgrade.value * 0.1)
    property string lastValidMeasurmentVehicleId: ""

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

        Column {
            anchors.centerIn: display
            Text {
                text: gameState.lastValidMeasurement <= 0 ? "-" : gameState.lastValidMeasurement
            }
            Text {
                font.pixelSize: 3
                text: gameState.lastValidMeasurmentVehicleId
            }
        }
    }

    Rectangle {
        id: handle
        color: "black"
        width: 20
        height: 30
        anchors {
            bottom: speedGunBase.bottom
            horizontalCenter: speedGunBase.horizontalCenter
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag {
                target: speedGunBase
                axis: Drag.XandYAxis
            }

            onReleased: {
                speedGunBase.x = 430
                speedGunBase.y = 315
            }
        }
    }

    Timer {
        id: fixateTimer

        running: false
        interval: speedGunBase.timeToFixate
        repeat: false

        onTriggered: {
            gameState.lastValidMeasurement = !targetedVehicle ? -1 : targetedVehicle.finalSpeed
            gameState.lastValidMeasurmentVehicleId = !targetedVehicle ? "" : targetedVehicle.entityId
        }

        function restartFixateTimer() {
            gameState.lastValidMeasurement = -1;
            gameState.lastValidMeasurmentVehicleId = "";
            fixateTimer.restart();
        }

        function forceStopFixateTimer() {
            gameState.lastValidMeasurement = -1;
            gameState.lastValidMeasurmentVehicleId = "";
            fixateTimer.stop();
        }
    }

    BoxCollider {
        anchors.fill: pointer
        collisionTestingOnlyMode: true

        property int colliderCounter: 0

        fixture.onBeginContact: {
            var body = other.getBody();
            targetedVehicle = body.target;
            fixateTimer.restartFixateTimer();
            colliderCounter++;
        }

        fixture.onEndContact: {
            colliderCounter--;
            if (colliderCounter == 0) {
                if (fixateTimer.running) {
                    fixateTimer.forceStopFixateTimer();
                }
                targetedVehicle = undefined;
            }
        }
    }

    state: "invalid"

    states: [
        State {
            name: "invalid"
            when: !fixateTimer.running && gameState.lastValidMeasurement <= 0
            PropertyChanges { target: display; color: "red"}
        },
        State {
            name: "progress"
            when: fixateTimer.running
            PropertyChanges { target: display; color: "yellow"}
        },
        State {
            name: "success"
            when: !fixateTimer.running && gameState.lastValidMeasurement > 0
            PropertyChanges { target: display; color: "green"}
        }

    ]

}
