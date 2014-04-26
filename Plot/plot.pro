TEMPLATE = lib
CONFIG += plugin
QT += qml quick

TARGET = Plot

HEADERS += \
	plugin.h \
    plot.h \

SOURCES += plot.cpp

qmldir.files=$$PWD/qmldir
qmldir.path=$$DESTDIR

INSTALLS += qmldir target

QMAKE_CXXFLAGS_RELEASE -= -O2
QMAKE_CXXFLAGS_RELEASE += -O3