import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
import Chaos.CPP 0.4
import "Utils.js" as Utils
import "Chaos.js" as Chaos

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "chaos"

    ChaosBuffer {
        id: core
    }

    FontLoader {
        id: mdl2
        source: "qrc:/fonts/SegMDL2.ttf"
    }

    ServerModel {
        id: serverModel
    }

    Component.onCompleted: {
        Config.serverLoaded.connect(serverModel.addServer)
        Config.loadServers()

    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "\uE700"
                font.family: mdl2.name
                onClicked: leftSide.open()
                rotation: leftSide.position * 90
            }
            Label {
                text: "chaos"
                Layout.fillWidth: true
            }
            ToolButton {
                text: "\uE712" + serverBar.currentIndex
                font.family: mdl2.name
                onClicked: rightSide.open()
                rotation: rightSide.position * 90
            }
        }
    }
    Drawer {
        id: leftSide
        height: parent.height
        width: parent.width * 0.66
        RowLayout {
            spacing: 10
            height: parent.height
            width: parent.width
            anchors.margins: 10
            ServerBar {
                id: serverBar
                model: serverModel
                width: 48
                Layout.fillHeight: true
                Component.onCompleted: console.log("serverBar", x, y, width, height)
            }
            BufferList {
                id: bufferList
                visible: !!serverBar.connection
                height: parent.height
                Layout.fillHeight: true
                Layout.fillWidth: true
                model: serverBar.connection.model
                Component.onCompleted: console.log("bufferList", x, y, width, height)
            }
            FriendList {
                id: friendList
                visible: !bufferList.visible
                height: parent.height
                model: Friends {Component.onCompleted: addFriend("Vigilance", serverModel.get(0).connection)}
                onProfile: {
                    picker.openWith(connection, name)
                }
                Layout.fillHeight: true
                Layout.fillWidth: true
                Component.onCompleted: console.log("friendList", x, y, width, height)
            }
        }
    }
    ListView {
        signal profile(string name)
        onProfile: picker.openWith(serverBar.connection, name)
        property bool switcher: true // TODO: dirty hack
        id: mainContent
        width: parent.width
        height: parent.height
        anchors.margins: 10
        model: serverBar.currentIndex === -1 ? core.model : serverBar.connection.model.get(bufferList.currentIndex).userData.model
        delegate: Item {
            width: mainContent.width
            height: 50
            Avatar {
                id: avatar
                height: 48
                anchors.margins: 1
                width: height
                source: {
                    mainContent.switcher // TODO: hack
                    Config.avatarFor(!!serverBar.connection ? serverBar.connection.displayName : null, sender)
                }
            }
            MouseArea {
                id: area
                cursorShape: Qt.PointingHandCursor
                anchors.fill: avatar
                onClicked: mainContent.profile(sender)
            }
            Label {
                id: from
                anchors.left: avatar.right
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                text: sender
            }
            Label {
                anchors.top: from.bottom
                anchors.left: avatar.right
                anchors.right: parent.right
                text: content
            }
        }
    }
    FileDialog {
        property Connection connection
        property string name
        id: picker
        function openWith(connection, name) {
            picker.connection = connection
            picker.name = name
            picker.open()
        }
        folder: shortcuts.home
        onAccepted: {
            Config.setAvatar(connection, name, fileUrl)
            mainContent.switcher = !mainContent.switcher
        }
    }

    footer: TextField {
        id: commandField
        signal join(string channel, string key)
        onJoin: {
            serverBar.connection.sendJoin(channel, key)
        }

        onAccepted: {
            if (text.startsWith("/")) {
                var rest = text.substring(1)
                var i = rest.indexOf(" ")
                var cmd, args
                if (i === -1) {
                    cmd = rest
                    args = null
                } else {
                    cmd = rest.substring(0, i)
                    args = rest.substring(i + 1)
                }
                cmd = cmd.toLocaleLowerCase()
                if (cmd === "") {
                    return
                }
                switch (cmd) {
                case "join":
                    if (args === null) return
                    args = args.split(" ")
                    var len = args.length
                    for (var j = 0; j < len; j++) {
                        var part = args[j]
                        i = part.indexOf(",")
                        if (i === -1) {
                            commandField.join(part, null)
                        } else {
                            commandField.join(part.substring(0, i), part.substring(i + 1))
                        }
                    }
                }
            } else {
                var cmd = Command.createMessage(bufferList.model.get(bufferList.currentIndex).title, text)
                serverBar.connection.sendCommand(cmd)
            }
        }
    }
}
