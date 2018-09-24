import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Item {
    property alias source: image.source
    Rectangle {
        id: mask
        anchors.fill: parent
        radius: height / 2
    }
    Image {
        id: image
        visible: false
        anchors.fill: parent
    }
    OpacityMask {
        anchors.fill: parent
        source: image
        maskSource: mask
    }
}
