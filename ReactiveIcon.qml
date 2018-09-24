import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    property bool selected: false
    property alias source: image.source
    signal clicked()
    Component.onCompleted: reactor.clicked.connect(clicked)
    Rectangle {
        id: mask
        anchors.fill: parent
        radius: height / ((selected
                           || reactor.containsMouse) ? 4 : 2)
        visible: false
    }
    Image {
        id: image
        anchors.fill: parent
        visible: false
    }
    Item {
        anchors.fill: parent
        OpacityMask {
            id: net
            anchors.fill: parent
            source: image
            maskSource: mask
        }
        MouseArea {
            id: reactor
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }
}
