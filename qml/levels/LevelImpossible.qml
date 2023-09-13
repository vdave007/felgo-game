import QtQuick 2.0
import Felgo 4.0
import "../common" as Common

Common.LevelBase {
    levelName: "Level3"

    speedLimit: 666

    minSpeedForCars: 90

    maxCarsOnRoad: 5
    speedModifier: 5
    spawnInterval: 500
    chanceForIgnorants: 1.0
}
