import QtQuick 2.0
import Communi 3.5
import Chaos.CPP 0.4

IrcConnection {
    id: ircConnection

    Component.onCompleted: {
        model.messageIgnored.connect(core.buffer.receiveMessage)
        model.add(core.buffer)
    }

    property CoreBuffer core: CoreBuffer {
        buffer.name: ircConnection.displayName
    }

    property IrcBufferModel model: IrcBufferModel {
        connection: ircConnection
        Component.onCompleted: {
            if (Config.open(core.name)) {
                open()
            }
        }
    }
}
