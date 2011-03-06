#include <QFileDialog>
#include <QTemporaryFile>
#include <QDebug>
#include "settingsdialog.h"

SettingsDialog::SettingsDialog(QuantController *aController)
        : controller(aController)
{
    setupUi(this);
    QObject::connect(this, SIGNAL(saveSettings(const QString&)), controller, SLOT(saveSettings(const QString&)));
    QObject::connect(controller, SIGNAL(gotNwtOutput(const QString&)), this, SLOT(settingsData(const QString&)));
    QObject::connect(controller, SIGNAL(nwtCompleted()), this, SLOT(settingsComplete()));
    controller->readSettings();
}

void SettingsDialog::settingsData(const QString& data)
{
    rawSettings += data;
}

void SettingsDialog::settingsComplete(void)
{
    QStringList lines = rawSettings.split("\n");
    for (int i = 0; i < lines.count(); i++) {
        QStringList nameValue = lines[i].split(":");
        if (nameValue[0] == "serial_port") {
            portEdit->setText(nameValue[1].trimmed());
        } else if (nameValue[0] == "serial_speed") {
            speedEdit->setText(nameValue[1].trimmed());
        } else if (nameValue[0] == "io_root") {
            rootEdit->setText(nameValue[1].trimmed());
        }
    }
    QObject::disconnect(this, SLOT(settingsData(const QString&)));
    QObject::disconnect(this, SLOT(settingsComplete()));
}

void SettingsDialog::on_selectRoot_clicked(void)
{
    QString dir = QFileDialog::getExistingDirectory(this, tr("Select Root"));
    rootEdit->setText(dir);
}

void SettingsDialog::on_buttonBox_accepted(void)
{
    QString settings;

    settings += "serial_speed: " + speedEdit->text() + "\n";
    settings += "serial_port: " + portEdit->text() + "\n";
    settings += "io_root: " + rootEdit->text() + "\n";
    emit saveSettings(settings);
}
