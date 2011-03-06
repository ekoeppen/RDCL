#include <QDebug>
#include <qtconcurrentrun.h>
#include "settingsdialog.h"
#include "quantcontrollerposix.h"

#define NWT_BUFFER_SIZE 1024

QuantControllerPosix::QuantControllerPosix(MainWindow *aMainWindow)
        : QuantController(aMainWindow)
{
}

void QuantControllerPosix::nwtBackgroundTask(const QString& args, const QString& input)
{
    int n;
    QString cmd("nwt ");

    cmd += args;
    FILE *f = popen(cmd.toAscii(), "r");
    if (input != "") {
        fwrite(input.toAscii(), 1, input.length(), f);
    }
    while (!feof(f)) {
        n = fread(nwtBuffer, 1, NWT_BUFFER_SIZE, f);
        nwtBuffer[n] = 0;
        emit gotNwtOutput(QString(nwtBuffer));
    }
    pclose(f);
    emit nwtCompleted();
}

void QuantControllerPosix::launchNwt(const QString& args, const QString& input)
{
    QtConcurrent::run(this, &QuantControllerPosix::nwtBackgroundTask, args, input);
}

QuantControllerPosix::~QuantControllerPosix()
{
}

void QuantControllerPosix::install(void)
{
    QString package = selectFile();
}

void QuantControllerPosix::uninstall(void)
{
}

void QuantControllerPosix::sync(void)
{
}

void QuantControllerPosix::backup(void)
{
}

void QuantControllerPosix::editSettings(void)
{
    launchSettingsDialog();
}
