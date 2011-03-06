#ifndef QUANTCONTROLLER_H
#define QUANTCONTROLLER_H

#include <QObject>
#include <QFileDialog>
#include <QTemporaryFile>

class MainWindow;

class QuantController : public QObject
{
    Q_OBJECT

public:
    static QuantController *controllerFactory(MainWindow *aMainWindow);
    virtual ~QuantController();

    virtual void readSettings(void);

protected:
    static const int NWT_BUFFER_SIZE = 1024;
    char nwtBuffer[NWT_BUFFER_SIZE + 1];

    QuantController(MainWindow *aMainWindow);
    QString selectFile(void);
    void launchSettingsDialog(void);
    virtual void launchNwt(const QString& args, const QString& input = "") = 0;

    MainWindow *mainWindow;
    char *settings;
    QTemporaryFile *tempFile;

public slots:
    virtual void getInfo(void);
    virtual void install(void);
    virtual void uninstall(void);
    virtual void sync(void);
    virtual void backup(void);
    virtual void editSettings(void);
    virtual void saveSettings(const QString& settings);
    virtual void cancel(void);

    void infoData(const QString& data);
    void infoCompleted(void);
    void saveSettingsCompleted(void);

signals:
    void gotNwtOutput(const QString& data);
    void nwtCompleted(void);
};

#endif // QUANTCONTROLLER_H
