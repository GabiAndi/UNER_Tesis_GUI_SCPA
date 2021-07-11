# Configuración de Qt
QT += quick network core

# Configuración del proyecto
CONFIG += c++11

# Ruta de importación adicional utilizada para resolver módulos QML en el modelo de código de Qt Creator
QML_IMPORT_PATH =

# Ruta de importación adicional utilizada para resolver módulos QML solo para Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Archivos de recursos
RESOURCES += qml.qrc

SOURCES += \
        hmimanager.cpp \
        main.cpp

HEADERS += \
        hmimanager.h
