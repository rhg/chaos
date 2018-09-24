#pragma once

#include <QAbstractListModel>

class IrcBufferModel;
class IrcConnection;

class Servers : public QAbstractListModel
{
    Q_OBJECT
    QList<IrcBufferModel*> mModels;
public:
    enum {
        NAME = Qt::UserRole + 1,
        MODEL
    };
    explicit Servers(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
signals:
    void newConnection(IrcConnection* connection);
    void newModel(IrcBufferModel* model);
public slots:
    void makeConnection(QString name, QString host, QString nick, QVariantMap optional);
    void makeModel(IrcConnection* connection);
};
