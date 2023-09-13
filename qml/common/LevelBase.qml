import QtQuick 2.0
import Felgo 4.0

Item {
    id: root
    // this will be displayed in the GameScene
    property string levelName
    // this is emitted whenever the rectangle has been tapped successfully, the GameScene will listen to this signal and increase the score
    signal rectanglePressed

    property int maxSpeedForCars
    property int minSpeedForCars

    property int carCounter: 0
    property int maxCarsOnRoad: 1
    property real speedModifier: 1.0
    property real chanceForIgnorants: 0.0
    property int spawnInterval: 2000
    property int speedLimit: 50

    // reference to the game state
    property GameState gameState
    property UpgradeManager upgradeManager

    Storage {
        id: storage
    }

    CarBuilder {
        id: carBuilder
        speedModifier: root.speedModifier
        minSpeedForCars: root.minSpeedForCars
        chanceForIgnorants: root.chanceForIgnorants
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

        if (!gameState.sirenRunning && currentNumberOfCars < maxCarsOnRoad) {
            carBuilder.generateRandomType();
        }
    }

    function spawnCar() {
        carBuilder.generateRandomType();
    }
}
