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

DISTFILES += \
    android/AndroidManifest.xml \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/build.gradle \
    android/gradle.properties \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew \
    android/gradlew.bat \
    android/gradlew.bat \
    android/res/values/libs.xml \
    android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
