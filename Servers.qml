import QtQuick 2.4
import Chaos.CPP 0.4

ListView {
    id: listView
    //Component.onCompleted: print(x, y, width, height)
    delegate: Item {
        height: reactiveIcon.height
        width: height
        ReactiveIcon {
            anchors.fill: parent
            source: Config.iconPath(name)
            selected: listView.currentIndex === index
            onClicked: listView.currentIndex = index
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
