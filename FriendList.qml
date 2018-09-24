import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Chaos.CPP 0.4
import "Utils.js" as Utils

ListView {
    signal profile(string name, Connection connection)
    id: friendList
    // TODO: change back
    delegate: Item {
        width: friendList.width
        height: 50
        anchors.margins: 5
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
            cursorShape: Qt.PointingHandCursor
            onClicked: friendList.currentIndex = index
        }
        Avatar {
            id : avatar
            anchors.left: parent.left
            width: 48
            height: 48
            anchors.verticalCenter: parent.verticalCenter
            source: {
                mainContent.switcher // TODO: really ugly
                Config.avatarFor(connection.displayName, name)
            }
        }
        MouseArea {
            anchors.fill: avatar
            onClicked: friendList.profile(name, connection)
            cursorShape: Qt.PointingHandCursor
        }
        Rectangle {
            id: status
            anchors.right: avatar.right
            anchors.bottom: avatar.bottom
            height: 12
            width: 12
            radius: height / 2
            color: "#808080"
        }
        Label {
            text: name
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: avatar.right
            anchors.leftMargin: 5
            anchors.right: parent.right
        }
    }
}
