import QtQuick 2.0
import Felgo 4.0

Item {
    // this will be displayed in the GameScene
    property string levelName
    // this is emitted whenever the rectangle has been tapped successfully, the GameScene will listen to this signal and increase the score
    signal rectanglePressed

    property int maxSpeedForCars
    property int minSpeedForCars

    property int carCounter: 0
    property int maxCarsOnRoad
    property real speedModifier
    property int spawnInterval: 2000

    // reference to the game state
    property GameState gameState
    property UpgradeManager upgradeManager

    readonly property real sirenModifier: 1 - (upgradeManager.sirenUpgrade.value * 0.1)

    Storage {
        id: storage
    }



    Timer {
        id: spawnTimer

        interval: spawnInterval
        running: gameState.gameRunning
        repeat: true

        onTriggered: {
            trySpawn();
        }
    }

    function trySpawn() {
        const currentNumberOfCars = entityManager.getEntityArrayByType("Vehicle").length;
        console.log("Currently active cars: ", currentNumberOfCars);

        if (!gameState.sirenRunning && currentNumberOfCars < maxCarsOnRoad) {
            spawnCar();
        }
    }

    function spawnCar() {
        let theId = "car_id_" + carCounter;
        let theSpeed = Math.floor(Math.random() * (maxSpeedForCars - minSpeedForCars) + minSpeedForCars);
        let y = (theSpeed % 2) ? 110 : 60;
        carCounter = carCounter + 1;
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/VehicleEntity.qml"),
                                                        {"x": 0, "y": y,
                                                            "entityId": theId,
                                                            "velocity" : theSpeed,
                                                            "speedModifier": Qt.binding(getSpeedModifier),
                                                            "gameState": gameState
                                                        });
    }

    function getSpeedModifier() {
        if (gameState.sirenRunning) {
            return speedModifier * sirenModifier;
        } else {
            return speedModifier;
        }
    }

}
