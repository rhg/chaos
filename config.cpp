#include "config.h"
#include <QSettings>
#include <QSet>
#include <IrcConnection>

static const QSet<QString> allowedProps = {"realName"}; // TODO: add more optionals

Config::Config(QObject *parent) : QObject(parent)
{

}

QUrl Config::iconPath(QString serverName) {
    QSettings s;
    return s.value(serverName + "/icon").toUrl();
}

void Config::loadServers() {
    QSettings s;
    for (auto name : s.value("irc/connections", QStringList()).toStringList()) {
        s.beginGroup(name);
        auto host = s.value("host");
        auto nick = s.value("nickName");
        auto user = s.value("userName");
        if (host.isNull() || nick.isNull() || user.isNull()) {
            return;
        }
        QVariantMap m;
        for (auto prop : allowedProps) {
            m[prop] = s.value(prop);
        }
        s.endGroup();
        emit serverLoaded(name, host.toString(), nick.toString(), user.toString(), m);
    }
}

bool Config::open(QString configName) {
    return QSettings().value(configName + "/open", false).toBool();
}

QUrl Config::avatarFor(QVariant server, QString sender) {
    QSettings s;
    if (server.isNull())
        return s.value("avatars/" + sender).toUrl();
    else
        return s.value(server.toString() + "/avatars/" + sender).toUrl();
}

void Config::setAvatar(QVariant connection, QString name, QUrl image) {
  QSettings s;
  if (connection.isNull()) {
      s.setValue("avatars/" + name, image);
    } else {
      s.setValue(connection.value<IrcConnection*>()->displayName() + "/avatars/" + name, image);
    }
}
