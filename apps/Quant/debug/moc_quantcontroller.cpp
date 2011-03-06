/****************************************************************************
** Meta object code from reading C++ file 'quantcontroller.h'
**
** Created: Fri May 15 22:21:04 2009
**      by: The Qt Meta Object Compiler version 61 (Qt 4.5.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../quantcontroller.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'quantcontroller.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 61
#error "This file was generated using the moc from 4.5.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QuantController[] = {

 // content:
       2,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   12, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors

 // signals: signature, parameters, type, tag, flags
      22,   17,   16,   16, 0x05,
      44,   16,   16,   16, 0x05,

 // slots: signature, parameters, type, tag, flags
      59,   16,   16,   16, 0x0a,
      69,   16,   16,   16, 0x0a,
      79,   16,   16,   16, 0x0a,
      91,   16,   16,   16, 0x0a,
      98,   16,   16,   16, 0x0a,
     107,   16,   16,   16, 0x0a,
     131,  122,   16,   16, 0x0a,
     153,   16,   16,   16, 0x0a,
     162,   17,   16,   16, 0x0a,
     180,   16,   16,   16, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_QuantController[] = {
    "QuantController\0\0data\0gotNwtOutput(QString)\0"
    "nwtCompleted()\0getInfo()\0install()\0"
    "uninstall()\0sync()\0backup()\0editSettings()\0"
    "settings\0saveSettings(QString)\0cancel()\0"
    "infoData(QString)\0infoCompleted()\0"
};

const QMetaObject QuantController::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QuantController,
      qt_meta_data_QuantController, 0 }
};

const QMetaObject *QuantController::metaObject() const
{
    return &staticMetaObject;
}

void *QuantController::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QuantController))
        return static_cast<void*>(const_cast< QuantController*>(this));
    return QObject::qt_metacast(_clname);
}

int QuantController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: gotNwtOutput((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: nwtCompleted(); break;
        case 2: getInfo(); break;
        case 3: install(); break;
        case 4: uninstall(); break;
        case 5: sync(); break;
        case 6: backup(); break;
        case 7: editSettings(); break;
        case 8: saveSettings((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 9: cancel(); break;
        case 10: infoData((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 11: infoCompleted(); break;
        default: ;
        }
        _id -= 12;
    }
    return _id;
}

// SIGNAL 0
void QuantController::gotNwtOutput(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QuantController::nwtCompleted()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
QT_END_MOC_NAMESPACE
