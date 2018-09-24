#include "servers.h"
#include <utility>
#include <IrcConnection>
#include <IrcBufferModel>
#include <IrcBuffer>

Servers::Servers(QObject *parent) : QAbstractListModel(parent)
{

}

QHash<int, QByteArray> Servers::roleNames() const {
    return {std::make_pair(NAME, "name"),
            std::make_pair(MODEL, "model")};
}

QVariant Servers::data(const QModelIndex &index, int role) const {
    switch (role) {
    case NAME:
        return mModels.at(index.row())->connection()->objectName();
    case MODEL:
        return QVariant::fromValue(mModels.at(index.row()));
    case Qt::DisplayRole:
        return mModels.at(index.row())->network()->name();
    default:
        return QVariant();
    }
}

int Servers::rowCount(const QModelIndex &) const {
    return mModels.length();
}

void Servers::makeConnection(QString name, QString host, QString nick, QVariantMap optional) {
    auto connection = new IrcConnection(this);
    connection->setObjectName(name);
    connection->setHost(host);
    connection->setNickName(nick);
    for (auto entry : optional.keys()) {
        auto val = optional.value(entry);
        if (!val.isNull())
            connection->setProperty(entry.toUtf8(), optional.value(entry));
    }
    emit newConnection(connection);
}

void Servers::makeModel(IrcConnection* connection) {
    auto model = new IrcBufferModel(this);
    model->setConnection(connection);
    emit newModel(model);
}
