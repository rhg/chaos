import QtQuick 2.0
import Communi 3.5

ListModel {
    id: model
    function addServer(name, host, nick, user, optional) { // TODO: use optionals
        var comp = Qt.createComponent("Connection.qml")
        console.assert(comp.status === Component.Ready)
        var props = {
            "displayName": name,
            "host": host,
            "nickName": nick, // TODO: support multiple nicks
            "userName": user
        }
        for (var attr in optional) {
            props[attr] = optional[attr]
        }
        var conn = comp.createObject(Qt.application, props)
        model.append({
                         "connection": conn,
                         "name": name
                     })
    }
}
