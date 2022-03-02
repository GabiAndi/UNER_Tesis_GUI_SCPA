cmake_minimum_required(VERSION 3.16)

project(GUI_SCPA VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)
find_package(Qt6 COMPONENTS Network REQUIRED)
find_package(Qt6 COMPONENTS Svg REQUIRED)

# Libreria de protocolo de comunicacíon
add_subdirectory("../HMIProtocol" "../build-HMIProtocol")

qt_add_executable(${PROJECT_NAME}
    "main.cpp"
    "guiscpamanager.h" "guiscpamanager.cpp"
    "hmiclientmanager.h" "hmiclientmanager.cpp"
)

qt_add_resources(${PROJECT_NAME} "resources"
    PREFIX
        "/"
    FILES
        "main.qml"
        "qtquickcontrols2.conf"
        "items/HMICircularProgressBar.qml"
        "items/HMISCPAVariableIndicator.qml"
        "items/HMISCPAMotorStatus.qml"
        "dialogs/HMIDialogClientErrorConnected.qml"
        "dialogs/HMIDialogClientDisconnected.qml"
        "dialogs/HMIDialogClientErrorDisconnected.qml"
        "dialogs/HMIDialogLoginForceRequired.qml"
        "dialogs/HMIDialogLoginCorrect.qml"
        "dialogs/HMIDialogLoginError.qml"
        "dialogs/HMIDialogLoginTimeOut.qml"
        "dialogs/HMIDialogOtherUserLogin.qml"
        "process/HMISCPAPileta.svg"
        "process/HMISCPASopladores.svg"
        "icons/HMISCPAOD.svg"
        "icons/HMISCPALv.svg"
        "icons/HMISCPATemp.svg"
        "icons/HMISCPASopladorOn.svg"
        "icons/HMISCPASopladorOff.svg"
        "icons/HMISCPASopladorFail.svg"
        "pages/HMIConnect.qml"
        "pages/HMIConnectForm.ui.qml"
        "pages/HMILogin.qml"
        "pages/HMILoginForm.ui.qml"
        "pages/HMISCPATop.qml"
        "pages/HMISCPATopForm.ui.qml"
        "pages/HMISCPASopladores.qml"
        "pages/HMISCPASopladoresForm.ui.qml"
        "pages/HMISCPASimulacion.qml"
        "pages/HMISCPASimulacionForm.ui.qml"
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt6::Quick
        Qt6::Network
        Qt6::Svg
        HMIProtocol
)

set(INSTALL_DESTDIR "/tmp/${PROJECT_NAME}")

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION "${INSTALL_DESTDIR}"
    BUNDLE DESTINATION "${INSTALL_DESTDIR}"
    LIBRARY DESTINATION "${INSTALL_DESTDIR}"
)
