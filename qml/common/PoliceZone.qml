import QtQuick 2.0
import Felgo 4.0
import QtMultimedia

Item {
    property GameState gameState

    Connections {
        target: gameState

        onSirenRunningChanged: {
            if (gameState.sirenRunning) {
                sirenSprite.start();
                //                sirenSound.play();
            } else {
                sirenSprite.stop();
                sirenSprite.currentFrame = 0;
                //                sirenSound.stop();
            }
        }
    }

    width: 150
    height: 50

    Image {
        source: Qt.resolvedUrl("../../assets/cars/CopCar-GTA2")
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter


        AnimatedSprite {
            id: sirenSprite
            anchors.centerIn: parent
            running: false
            frameCount:5
            frameWidth: 64
            frameHeight: 64
            source: Qt.resolvedUrl("../../assets/img/siren.png")

            // update the animation 20 times per second
            frameRate: 5
        }
    }

    // Bug in sound effects: https://bugreports.qt.io/browse/QTBUG-108383
    //    SoundEffect {
    //     id: sirenSound
    //     source: "../../assets/sounds/sample-3s.wav"
    //     loops: SoundEffect.Infinite
    //   }

}
