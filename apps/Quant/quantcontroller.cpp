#include <QFileDialog>
#include <QDebug>
#include "mainwindow.h"
#include "quantcontroller.h"
#include "settingsdialog.h"
#ifdef Q_WS_WIN
#include "quantcontrollerwindows.h"
#else
#include "quantcontrollerposix.h"
#endif

QuantController *QuantController::controllerFactory(MainWindow *aMainWindow)
{
#ifdef Q_WS_WIN
    return new QuantControllerWindows(aMainWindow);
#else
    return new QuantControllerPosix(aMainWindow);
#endif
}

QuantController::QuantController(MainWindow *aMainWindow)
        : mainWindow(aMainWindow), settings(NULL)
{
}

QuantController::~QuantController()
{
    if (settings) {
        delete settings;
        settings = NULL;
    }
}

QString QuantController::selectFile(void)
{
    return QFileDialog::getOpenFileName(mainWindow, tr("Select Package File"));
}

void QuantController::getInfo(void)
{
    mainWindow->clearOutput();
    mainWindow->disableButtons();
    QObject::connect(this, SIGNAL(gotNwtOutput(const QString&)), this, SLOT(infoData(const QString&)));
    QObject::connect(this, SIGNAL(nwtCompleted()), this, SLOT(infoCompleted()));
    launchNwt(QString("-n"));
}

void QuantController::install(void)
{
}

void QuantController::uninstall(void)
{
}

void QuantController::sync(void)
{
}

void QuantController::backup(void)
{
}

void QuantController::editSettings(void)
{
}

void QuantController::readSettings(void)
{
    launchNwt(QString("--show-settings"));
}

void QuantController::saveSettings(const QString& settings)
{
    QTemporaryFile* file = new QTemporaryFile();
    QString cmd("--write-settings ");

    file->open();
    cmd += file->fileName();
    file->write(settings.toAscii());
    file->close();
    tempFile = file;
    QObject::connect(this, SIGNAL(nwtCompleted()), this, SLOT(saveSettingsCompleted()));
    launchNwt(cmd);
}

void QuantController::launchSettingsDialog(void)
{
    SettingsDialog settings(this);

    settings.exec();
}

void QuantController::infoData(const QString& data)
{
    mainWindow->addOutput(data);
    qDebug() << data;
}

void QuantController::infoCompleted(void)
{
    QObject::disconnect(this, SIGNAL(gotNwtOutput(const QString&)));
    QObject::disconnect(this, SIGNAL(nwtCompleted()));
    mainWindow->enableButtons();
}

void QuantController::cancel(void)
{
}

void QuantController::saveSettingsCompleted(void)
{
    tempFile->remove();
    delete tempFile;
    QObject::disconnect(this, SLOT(saveSettingsCompleted()));
}

