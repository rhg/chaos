function getConnection() {
    var i = serverBar.currentIndex
    return serverModel.get(i).connection
}

function getBufferModel() {
    return getConnection().model
}
