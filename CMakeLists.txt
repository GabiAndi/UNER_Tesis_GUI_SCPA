cmake_minimum_required(VERSION 3.16)

project(GUI_SCPA VERSION 0.0.1 LANGUAGES CXX)

set(APP_NAME appGUI_SCPA)

set(CMAKE_AUTOMOC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)

set(PROJECT_SOURCES
    main.cpp
    guiscpamanager.h guiscpamanager.cpp
)

qt_add_executable(${APP_NAME} MANUAL_FINALIZATION ${PROJECT_SOURCES})

qt_add_qml_module(${APP_NAME}
    URI ${PROJECT_NAME}
    VERSION ${PROJECT_VERSION}
    QML_FILES
        main.qml
)

target_link_libraries(${APP_NAME} PRIVATE Qt6::Quick)

qt_finalize_executable(${APP_NAME})
