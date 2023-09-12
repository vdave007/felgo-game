import QtQuick 2.0
import Felgo 4.0

Item {

    property var sirenUpgrade
    property var speedGunUpgrade

    Component.onCompleted: {
       loadUpgrades();
    }

    Storage {
        id: storage
    }

    function upgradeSpeedGun() {
        if(speedGunUpgrade.value < 10) {
            speedGunUpgrade.value++;
            storage.setValue(speedGunUpgrade.id, speedGunUpgrade);
            loadUpgrades();
        }

    }

    function upgradeSiren() {
        if(sirenUpgrade.value < 10) {
            sirenUpgrade.value++;
            storage.setValue(sirenUpgrade.id, sirenUpgrade);
            loadUpgrades();
        }
    }

    function resetUpgrades() {
        storage.clearAll();
        loadUpgrades();
    }

    function loadUpgrades() {
        let tempSirenUpgrade = storage.getValue("sirenUpgrade")
        let tempSpeedGunUpgrade = storage.getValue("speedGunUpgrade");

        if(!tempSirenUpgrade) {
          tempSirenUpgrade = {id: "sirenUpgrade", value: 1, description: "Siren upgrade"};
          storage.setValue(tempSirenUpgrade.id, tempSirenUpgrade);
        }

        if(!tempSpeedGunUpgrade) {
            tempSpeedGunUpgrade = {id: "speedGunUpgrade", value: 1, description: "Updgrade for the speed gun"};
            storage.setValue(tempSpeedGunUpgrade.id, tempSpeedGunUpgrade);
        }

        sirenUpgrade = tempSirenUpgrade;
        speedGunUpgrade = tempSpeedGunUpgrade;
    }
}
