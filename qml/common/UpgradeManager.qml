import QtQuick 2.0
import Felgo 4.0

Item {

    property bool debugModifier: true
    property var sirenUpgrade
    property var speedGunUpgrade
    property var money

    readonly property int speedGunInitialTimeToFixate: 2000
    readonly property real speedGunModifier: 1 - (speedGunUpgrade.value * 0.1)
    readonly property real sirenModifier: 1 - (sirenUpgrade.value * 0.1)

    Component.onCompleted: {
       loadUpgrades();
    }

    Storage {
        id: storage
    }

    function upgradeSpeedGun() {
        if(speedGunUpgrade.value < 10) {
            if (money.value > 0 || debugModifier) {
                money.value--;
                storage.setValue(money.id, money);
                speedGunUpgrade.value++;
                storage.setValue(speedGunUpgrade.id, speedGunUpgrade);
                loadUpgrades();
            } else {
                console.log("NOT ENOUGH MONEY!");
            }
        }
    }

    function upgradeSiren() {
        if(sirenUpgrade.value < 10) {
            if (money.value > 0 || debugModifier) {
                money.value--;
                storage.setValue(money.id, money);
                sirenUpgrade.value++;
                storage.setValue(sirenUpgrade.id, sirenUpgrade);
                loadUpgrades();
            } else {
                console.log("NOT ENOUGH MONEY!");
            }
        }
    }

    function addMoney(amount) {
        money.value += amount;
        storage.setValue(money.id, money);
        loadUpgrades();
    }

    function removeMoney(amount) {
        money.value -= amount;
        storage.setValue(money.id, money);
        loadUpgrades();
    }

    function resetUpgrades() {
        storage.clearAll();
        loadUpgrades();
    }

    function loadUpgrades() {
        let tempSirenUpgrade = storage.getValue("sirenUpgrade")
        let tempSpeedGunUpgrade = storage.getValue("speedGunUpgrade");
        let tempMoney = storage.getValue("money");


        if(!tempSirenUpgrade) {
          tempSirenUpgrade = {id: "sirenUpgrade", value: 1, description: "Siren upgrade"};
          storage.setValue(tempSirenUpgrade.id, tempSirenUpgrade);
        }

        if(!tempSpeedGunUpgrade) {
            tempSpeedGunUpgrade = {id: "speedGunUpgrade", value: 1, description: "Updgrade for the speed gun"};
            storage.setValue(tempSpeedGunUpgrade.id, tempSpeedGunUpgrade);
        }

        if(!tempMoney) {
            tempMoney = {id: "money", value: 0, description: "Money to upgrade"};
            storage.setValue(tempMoney.id, tempMoney);
        }

        sirenUpgrade = tempSirenUpgrade;
        speedGunUpgrade = tempSpeedGunUpgrade;
        money = tempMoney ;
    }
}
