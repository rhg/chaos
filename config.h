#pragma once

#include <QObject>
#include <QUrl>
#include <QMap>
#include <QVariant>

class Config : public QObject
{
    Q_OBJECT
public:
    explicit Config(QObject *parent = nullptr);
    Q_INVOKABLE QUrl iconPath(QString serverName);
    Q_INVOKABLE bool open(QString configName);
    Q_INVOKABLE QUrl avatarFor(QVariant connection, QString sender);
signals:
    void serverLoaded(QString name, QString host, QString nick, QString user, QVariantMap optional);
public slots:
    void loadServers();
    void setAvatar(QVariant connection, QString name, QUrl image);
};
