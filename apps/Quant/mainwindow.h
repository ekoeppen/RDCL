#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QWidget>
#include <QPushButton>
#include <QBoxLayout>
#include <QTextEdit>

namespace Ui
{
    class MainWindowClass;
}

class QuantController;

class MainWindow : public QWidget
{
    Q_OBJECT

public:
    enum {
        InfoButton = 0,
        InstallButton = 1,
        UninstallButton = 2,
        BackupButton = 3,
        SyncButton = 4,
        CancelButton = 5,
        SettingsButton = 6,
        LastButton
    };

    MainWindow(QWidget *parent = 0);
    ~MainWindow();

    void disableButtons();
    void enableButtons();

    void clearOutput();
    void addOutput(const QString& output);

private:
    QPushButton *buttons[LastButton];
    QTextEdit *m_output;
    QuantController *controller;

    void setupButtons(QBoxLayout *parentLayout);

private slots:
};

#endif // MAINWINDOW_H
