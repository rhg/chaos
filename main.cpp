#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <IrcCore>
#include <IrcModel>
#include <IrcUtil>

#include <config.h>

void registerCommuni(const char* uri) {
    // IrcCore
    Irc::registerMetaTypes();
    qmlRegisterType<Irc>(uri, 3, 0, "Irc");
    qmlRegisterType<Irc>(uri, 3, 2, "Irc");
    qmlRegisterType<Irc>(uri, 3, 3, "Irc");
    qmlRegisterType<Irc>(uri, 3, 4, "Irc");
    qmlRegisterType<Irc>(uri, 3, 5, "Irc");
    qmlRegisterType<IrcCommand>(uri, 3, 0, "IrcCommand");
    qmlRegisterType<IrcConnection>(uri, 3, 0, "IrcConnection");
    qmlRegisterUncreatableType<IrcMessage>(uri, 3, 0, "IrcMessage", "Cannot create an instance of IrcMessage. Use IrcConnection::messageReceived() signal instead.");
    qmlRegisterUncreatableType<IrcNetwork>(uri, 3, 0, "IrcNetwork", "Cannot create an instance of IrcNetwork. Use IrcConnection::network property instead.");
    // IrcModel
    qmlRegisterType<IrcBuffer>(uri, 3, 0, "IrcBuffer");
    qmlRegisterType<IrcBufferModel>(uri, 3, 0, "IrcBufferModel");
    qmlRegisterType<IrcChannel>(uri, 3, 0, "IrcChannel");
    qmlRegisterType<IrcUser>(uri, 3, 0, "IrcUser");
    qmlRegisterType<IrcUserModel>(uri, 3, 0, "IrcUserModel");
    // IrcUtil
    qmlRegisterType<IrcCommandParser>(uri, 3, 0, "IrcCommandParser");
    qmlRegisterType<IrcLagTimer>(uri, 3, 0, "IrcLagTimer");
    qmlRegisterType<IrcTextFormat>(uri, 3, 0, "IrcTextFormat");
    qmlRegisterUncreatableType<IrcPalette>(uri, 3, 0, "IrcPalette", "Cannot create an instance of IrcPalette. Use IrcTextFormat::palette property instead.");
    qmlRegisterType<IrcCompleter>(uri, 3, 1, "IrcCompleter");
}

QObject* new_config(QQmlEngine*, QJSEngine*) {
    return new Config;
}

QObject* new_command(QQmlEngine*, QJSEngine*) {
    return new IrcCommand;
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setApplicationName("chaos");
    app.setApplicationVersion("0.4");
    app.setOrganizationName("rhg135");
    app.setOrganizationDomain("rhg135.com");

    qmlRegisterSingletonType<Config>("Chaos.CPP", 0, 4, "Config", new_config);
    qmlRegisterSingletonType<IrcCommand>("Chaos.CPP", 0, 4, "Command", new_command);
    registerCommuni("Communi");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
