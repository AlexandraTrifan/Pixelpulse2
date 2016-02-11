TEMPLATE = app

QT += qml quick widgets
QT += network
CONFIG += c++11

win32 {
        CONFIG += release
}
unix {
        CONFIG += release
}

QMAKE_CFLAGS_DEBUG += -ggdb
QMAKE_CXXFLAGS_DEBUG += -ggdb

CFLAGS += -v -static -static-libgcc -static-libstdc++ -g

DEFINES += GIT_VERSION='"\\\"$(shell git -C $$PWD describe --always --tags --abbrev)\\\""'
DEFINES += BUILD_DATE='"\\\"$(shell date +%F)\\\""'

SOURCES += main.cpp \
    SMU.cpp \
    Plot/PhosphorRender.cpp \
    Plot/FloatBuffer.cpp \
    libsmu/device_m1000.cpp \
    libsmu/session.cpp \
    libsmu/device_cee.cpp \
    utils/filedownloader.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in the Qt Creator code model
QML_IMPORT_PATH =

OTHER_FILES += \
    qml/main.qml \
    qml/Toolbar.qml \
    qml/PlotPane.qml \
    qml/DeviceManagerPane.qml \
    qml/ToolbarStyle.qml \
    qml/ContentPane.qml \
    qml/XYPlot.qml \
    qml/Controller.qml \
    qml/SignalRow.qml \
    qml/ChannelRow.qml \
    qml/OverlayConstant.qml \
    qml/TimelineFlickable.qml \
    qml/TimelineHeader.qml \
    qml/Axes.qml \
    qml/OverlayPeriodic.qml \
    qml/DragDot.qml \
    qml/DeviceRow.qml

HEADERS += \
    SMU.h \
    Plot/PhosphorRender.h \
    Plot/FloatBuffer.h \
    libsmu/device_m1000.hpp \
    libsmu/libsmu.h \
    libsmu/libsmu.hpp \
    libsmu/device_cee.hpp \
    libsmu/internal.hpp \
    utils/fileio.h \
    utils/bossac_wrap.h \
    utils/filedownloader.h

win32:debug {
#	CONFIG += console
	LIBS += -limagehlp -ldbghelp
}


osx {
	ICON = icons/pp2.icns
        LIBS += -lobjc -framework IOKit -framework CoreFoundation
        INCLUDEPATH += /usr/local/opt/qt5/include
        QT_LOGGING_RULES=qt.network.ssl.warning=false
}

win32 {
	RC_ICONS = icons/pp2.ico
	LIBS += "C:\libusb\libusb-1.0.a"
	INCLUDEPATH += "C:\libusb\include"
	contains(QT_ARCH, x86_64) {
		INCLUDEPATH += "C:\mingw64\include"
	} else {
		INCLUDEPATH += "C:\mingw32\include"
	}
}

unix {
	CONFIG += link_pkgconfig
# if we do not have a locally compiled static version of libusb-1.0 installed, use pkg-config
	!exists(/usr/local/lib/libusb-1.0.a) {
		PKGCONFIG += libusb-1.0
	}
# if we do have a locally compiled static version of libusb-1.0 installed, use it
	exists(/usr/local/lib/libusb-1.0.a) {
		LIBS += /usr/local/lib/libusb-1.0.a
                INCLUDEPATH += "/usr/local/include/libusb-1.0"
	}
}

unix:!osx {
	PKGCONFIG += libudev
	INSTALLS+=target
	isEmpty(PREFIX) {
		PREFIX = /usr
	}
	BINDIR = $$PREFIX/bin
	target.path=$$BINDIR
	QMAKE_CFLAGS_DEBUG += -rdynamic
	QMAKE_CXXFLAGS_DEBUG += -rdynamic
}


