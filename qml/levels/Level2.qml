import QtQuick 2.0
import Felgo 4.0
import "../common" as Common

Common.LevelBase {
    levelName: "Level2"

    maxSpeedForCars: 130
    minSpeedForCars: 30

    maxCarsOnRoad: 3
    speedModifier: 2
    spawnInterval: 1000
}
