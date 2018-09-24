import QtQuick 2.4

ServerBarForm {
    property Connection connection: currentIndex === -1 ? null : model.get(currentIndex).connection
}
