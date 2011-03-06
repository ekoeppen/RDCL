#ifndef QUANTCONTROLLERWINDOWS_H
#define QUANTCONTROLLERWINDOWS_H

#include <windows.h>
#include "quantcontroller.h"

class QuantControllerWindows : public QuantController
{
public:
    QuantControllerWindows(MainWindow *aMainWindow);
    ~QuantControllerWindows();

protected:
    virtual void launchNwt(const QString& args, const QString& input = "");
    HANDLE pipe;

public slots:
    virtual void install(void);
    virtual void uninstall(void);
    virtual void sync(void);
    virtual void backup(void);
    virtual void editSettings(void);
};

#endif // QUANTCONTROLLERWINDOWS_H
