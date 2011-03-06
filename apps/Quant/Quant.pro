# -------------------------------------------------
# Project created by QtCreator 2009-05-09T10:17:05
# -------------------------------------------------
TARGET = Quant
TEMPLATE = app
SOURCES += main.cpp \
    mainwindow.cpp \
    quantcontroller.cpp \
    quantcontrollerposix.cpp \
    settingsdialog.cpp
win32:SOURCES += quantcontrollerwindows.cpp
HEADERS += mainwindow.h \
    quantcontroller.h \
    quantcontrollerwindows.h \
    quantcontrollerposix.h \
    settingsdialog.h
FORMS += settingsdialog.ui
