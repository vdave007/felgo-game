import QtQuick 2.0
import Felgo 4.0

Item {
    id: root
    // this will be displayed in the GameScene
    property string levelName

    // Minimum speed of the generated vehicles
    property int minSpeedForCars

    // Maximum number of cars that can be concurrently on the road
    property int maxCarsOnRoad: 1
    // Multiplier for the speed. To increase difficulty
    property real speedModifier: 1.0
    // Chance to generate ignorant drivers. Ignorant drivers will ignore siren's speed reduction
    property real chanceForIgnorants: 0.0
    // The interval with which we generate new cars
    property int spawnInterval: 2000
    //Speed limt for the level
    property int speedLimit: 50

    // reference to the game state and upgrade manager
    property GameState gameState
    property UpgradeManager upgradeManager

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
