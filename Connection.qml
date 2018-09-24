import QtQuick 2.0
import Communi 3.5
import Chaos.CPP 0.4

IrcConnection {
    id: ircConnection

    function sendJoin(channel, key) {
        var cmd = Command.createJoin(channel, key)
        ircConnection.sendCommand(cmd)
    }

    Component.onCompleted: {
        model.messageIgnored.connect(buffer.receiveMessage)
        model.add(buffer)
    }

    property IrcBuffer buffer: IrcBuffer {
        name: ircConnection.displayName
    }
    property CoreBuffer core: CoreBuffer {
        canType: false
        buffer: ircConnection.buffer
    }
    property IrcBufferModel model: IrcBufferModel {
        connection: ircConnection
        Component.onCompleted: {
            if (Config.open(ircConnection.displayName)) {
                open()
            }
        }
        onAdded: {
            var core = Qt.createComponent("CoreBuffer.qml")
            if (core.status === Component.Ready) {
                var w = core.createObject(ircConnection, {buffer: buffer})
                buffer.userData = {model: w.model}
            }
        }
    }
}
