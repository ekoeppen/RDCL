#include <QVBoxLayout>
#include <QPushButton>
#include <QTextEdit>
#include <QApplication>
#include "quantcontroller.h"
#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QWidget(parent)
{
    controller = QuantController::controllerFactory(this);
    QHBoxLayout *topLayout = new QHBoxLayout;
    QVBoxLayout *buttonLayout = new QVBoxLayout;

    QWidget *buttonContainer = new QWidget();

    buttonContainer->setLayout(buttonLayout);
    buttonLayout->setAlignment(Qt::AlignTop);
    setupButtons(buttonLayout);

    m_output = new QTextEdit();
    m_output->setReadOnly(true);

    topLayout->addWidget(buttonContainer);
    topLayout->addWidget(m_output);
    setLayout(topLayout);
}

MainWindow::~MainWindow()
{
    delete controller;
}

void MainWindow::setupButtons(QBoxLayout *layout)
{
    buttons[InfoButton] = new QPushButton(tr("Info"));
    layout->addWidget(buttons[InfoButton]);
    QObject::connect(buttons[InfoButton], SIGNAL(clicked()), controller, SLOT(getInfo()));

    buttons[InstallButton] = new QPushButton(tr("Install"));
    layout->addWidget(buttons[InstallButton]);
    QObject::connect(buttons[InstallButton], SIGNAL(clicked()), controller, SLOT(install()));

    buttons[UninstallButton] = new QPushButton(tr("Uninstall"));
    layout->addWidget(buttons[UninstallButton]);
    QObject::connect(buttons[UninstallButton], SIGNAL(clicked()), controller, SLOT(uninstall()));

    buttons[BackupButton] = new QPushButton(tr("Backup"));
    layout->addWidget(buttons[BackupButton]);
    QObject::connect(buttons[BackupButton], SIGNAL(clicked()), controller, SLOT(backup()));

    buttons[SyncButton] = new QPushButton(tr("Sync"));
    layout->addWidget(buttons[SyncButton]);
    QObject::connect(buttons[SyncButton], SIGNAL(clicked()), controller, SLOT(sync()));

    buttons[CancelButton] = new QPushButton(tr("Cancel"));
    layout->addWidget(buttons[CancelButton]);
    buttons[CancelButton]->setDisabled(true);
    QObject::connect(buttons[CancelButton], SIGNAL(clicked()), controller, SLOT(cancel()));

    layout->addStretch(100);

    buttons[SettingsButton] = new QPushButton(tr("Settings"));
    layout->addWidget(buttons[SettingsButton]);
    QObject::connect(buttons[SettingsButton], SIGNAL(clicked()), controller, SLOT(editSettings()));
}

void MainWindow::addOutput(const QString& output)
{
    m_output->append(output);
}

void MainWindow::clearOutput()
{
    m_output->setText(QString(""));
}

void MainWindow::enableButtons()
{
    for (int i = 0; i < LastButton; i++) {
        buttons[i]->setDisabled(i == CancelButton ? true : false);
    }
}

void MainWindow::disableButtons()
{
    for (int i = 0; i < LastButton; i++) {
        buttons[i]->setDisabled(i == CancelButton ? false : true);
    }
}
