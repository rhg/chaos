import QtQuick 2.0

ListModel {
    id: friends
    function addFriend(name, connection) {
        friends.append({name: name, connection: connection})
    }
}
