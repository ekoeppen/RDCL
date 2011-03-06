#ifndef QUANTCONTROLLERPOSIX_H
#define QUANTCONTROLLERPOSIX_H

#include "quantcontroller.h"

class QuantControllerPosix : public QuantController
{
public:
    QuantControllerPosix(MainWindow *aMainWindow);
    ~QuantControllerPosix();

protected:
    virtual void launchNwt(const QString& args, const QString& input = "");
    void nwtBackgroundTask(const QString& args, const QString& input);

public slots:
    virtual void install(void);
    virtual void uninstall(void);
    virtual void sync(void);
    virtual void backup(void);
    virtual void editSettings(void);
};

#endif // QUANTCONTROLLERPOSIX_H
