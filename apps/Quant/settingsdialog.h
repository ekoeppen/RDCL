#ifndef SETTINGSDIALOG_H
#define SETTINGSDIALOG_H

#include <QDialog>
#include "ui_settingsdialog.h"
#include "quantcontroller.h"

class SettingsDialog : public QDialog, private Ui::SettingsDialog
{
    Q_OBJECT

    enum {
        SerialPort = 0,
        SerialSpeed = 1,
        IoRoot = 2,
        NumSettings
    };

    QuantController *controller;

    QString settingValues[NumSettings];
    QString rawSettings;

public:
    SettingsDialog(QuantController *aController);

public slots:
    void settingsData(const QString& data);
    void settingsComplete(void);

private slots:
    void on_selectRoot_clicked(void);
    void on_buttonBox_accepted(void);

signals:
    void saveSettings(const QString& settings);
};

#endif // SETTINGSDIALOG_H
