import QtQuick 2.0
import Communi 3.5

Item {
    property IrcBuffer buffer
    property bool canType: true
    property alias model: model
    ListModel {
        id: model
        Component.onCompleted: {
            model.append({sender: "chaos", content: "test2"})
        }
    }
    Connections {
        target: buffer
        onMessageReceived: {
            switch (message.type) {
            case IrcMessage.Notice:
               model.append({sender: message.nick, content: message.content})
                break
            case IrcMessage.Private:
                model.append({sender: message.nick, content: message.content})
                break
            }
        }
    }
}
