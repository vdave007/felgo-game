import QtQuick 2.0
import Felgo 4.0

Item {
    id: root
    property real speedModifier: 1
    property int minSpeedForCars: 30
    property real chanceForIgnorants: 0.0

    readonly property var types: ["standard","truck", "sport"]
    readonly property var cars: {
            "standard": {
                "maxspeed": 130,
                "possible_models": ["Bug-GTA2","Eddy-GTA2","Panto-GTA2", "T-Rex-GTA2", "Shark-GTA2", "Maurice-GTA2", "Taxi-GTA2", "TaxiXpress-GTA2", "Beamer-GTA2"]
            },
            "truck": {
                "maxspeed": 90,
                "possible_models": ["BoxTruck-GTA2","GarbageTruck-GTA2","G4BankVan-GTA2", "Ice-CreamVan-GTA2", "HotDogVan-GTA2"]
            },
            "sport": {
                "maxspeed": 220,
                "possible_models": ["Stinger-GTA2","Rumbler-GTA2","Jefferson-GTA2","AnistonBD4-GTA2","Benson-GTA2", "FuroreGT-GTA2","Hachura-GTA2","MichelliRoadster-GTA2", "Wellard-GTA2", "TranceAM-GTA2"]
            }
        }

   function generateLicensePlate() {
       return 'xx-xx-xxx'
           .replace(/[xy]/g, function (c) {
               const r = Math.random() * 16 | 0,
                   v = c == 'x' ? r : (r & 0x3 | 0x8);
               return v.toString(16);
           });
   }

   function generateCarType(typeToGen) {
       if (!types.includes(typeToGen)) {
           console.log("Invalid type");
           return false;
       }

       const possible_models = cars[typeToGen].possible_models;
       const carModel = possible_models[Math.floor(Math.random()*possible_models.length)]
       const maxSpeed = cars[typeToGen].maxspeed;

       let theSpeed = Math.floor(Math.random() * (maxSpeed - minSpeedForCars) + minSpeedForCars);
       let y = (theSpeed % 2) ? 83 : 38;
       const licensePlate = generateLicensePlate();
       const isIgnorant = Math.random() < chanceForIgnorants;

       entityManager.createEntityFromUrlWithProperties(
                   Qt.resolvedUrl("../entities/VehicleEntity.qml"),
                       {"x": 0, "y": y,
                           "entityId": licensePlate,
                           "maxSpeed": maxSpeed,
                           "velocity" : theSpeed,
                           "type": typeToGen,
                           "model": carModel,
                           "speedModifier": speedModifier,
                           "gameState": gameState,
                           "ignoresSiren": isIgnorant,
                           "upgradeManager": upgradeManager

                       });

       return true;
   }

   function generateRandomType() {
      generateCarType(types[Math.floor(Math.random()*types.length)]);
   }

}
