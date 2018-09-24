import QtQuick 2.4
import Chaos.CPP 0.4

Item {
    id: item1
    width: 100
    height: 400
    property alias model: listView.model
    property alias currentIndex: listView.currentIndex
    HomeButton {
        id: reactiveIcon
        anchors.left: parent.left
        anchors.right: parent.right
        height: width
        selected: listView.currentIndex === -1
        onClicked: listView.currentIndex = -1
    }

    Servers {
        id: listView
        Component.onCompleted: listView.currentIndex = -1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: reactiveIcon.bottom
        anchors.topMargin: 20
        spacing: 10
    }
}
