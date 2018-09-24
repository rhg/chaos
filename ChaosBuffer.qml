import QtQuick 2.0
import Communi 3.5

IrcBuffer {
    name: "chaos"
    property bool canType: false
    property ListModel model: ListModel {
        Component.onCompleted: append({sender: "chaos", content: "Welcome to chaos."})
    }
}
