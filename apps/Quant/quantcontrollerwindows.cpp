#include <QDebug>
#include <windows.h>
#include "quantcontrollerwindows.h"
#include "settingsdialog.h"

QuantControllerWindows::QuantControllerWindows(MainWindow *aMainWindow)
        : QuantController(aMainWindow)
{
    pipe = CreateNamedPipe(L"\\\\.\\pipe\\nwt", PIPE_ACCESS_DUPLEX,
                           PIPE_TYPE_BYTE, PIPE_UNLIMITED_INSTANCES,
                           1024, 1024, NMPWAIT_USE_DEFAULT_WAIT, NULL);
}

void QuantControllerWindows::launchNwt(const QString& args, const QString& input)
{
    int n;
    QString cmd("nwt ");

    cmd += args;
    FILE *f = popen(cmd.toAscii(), "r");
    while (!feof(f)) {
        n = fread(nwtBuffer, 1, NWT_BUFFER_SIZE, f);
        nwtBuffer[n] = 0;
        emit gotNwtOutput(QString(nwtBuffer));
        // qDebug() << nwtBuffer;
    }
    pclose(f);
    emit nwtCompleted();
}

QuantControllerWindows::~QuantControllerWindows()
{
    CloseHandle(pipe);
}

void QuantControllerWindows::install(void)
{
    QString package = selectFile();
}

void QuantControllerWindows::uninstall(void)
{
}

void QuantControllerWindows::sync(void)
{
}

void QuantControllerWindows::backup(void)
{
}

void QuantControllerWindows::editSettings(void)
{
    launchSettingsDialog();
}
