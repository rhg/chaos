.pragma library

function splitOnce(string, char) {
    var i = string.indexOf(char)
    return i === -1 ? [s] : [s.substring(0, i), s.substring(i + 1)]
}
