import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Chaos.CPP 0.4
import "Utils.js" as Utils

ListView {
    id: bufferList
    delegate: Item {
        width: bufferList.width
        height: 30
        Rectangle {
            id: bg
            anchors.fill: parent
            radius: height / 4
            color: reactor.containsMouse ? "#808080" : "#909090"
        }
        MouseArea {
            id: reactor
            hoverEnabled: true
            anchors.fill: parent
            onClicked: bufferList.currentIndex = index
        }
        Label {
            text: title
            anchors.centerIn: parent
        }
    }
}
