cmake_minimum_required(VERSION 3.16)

project(GUI_SCPA VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)
find_package(Qt6 COMPONENTS QuickControls2 REQUIRED)
find_package(Qt6 COMPONENTS Network REQUIRED)

# Libreria de protocolo de comunicacíon
add_subdirectory("../HMIProtocol" "../build-HMIProtocol")

qt_add_executable(${PROJECT_NAME}
    "main.cpp"
    "guiscpamanager.h"
    "guiscpamanager.cpp"
    "hmiclientmanager.h"
    "hmiclientmanager.cpp"
)

qt_add_resources(${PROJECT_NAME} "resources"
    PREFIX
        "/"
    FILES
        "main.qml"
        "qtquickcontrols2.conf"
        "items/HMICircularProgressBar.qml"
        "items/HMIButton.qml"
        "items/HMIDialogLoginCorrect.qml"
        "pages/PageHome.qml"
        "pages/PageSCPATop.qml"
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::Network
        HMIProtocol
)
