import "pages"
import "dialogs"

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import GUISCPA

ApplicationWindow {
    id: applicationWindow

    // Propiedades
    property string serverIP: ""
    property string serverPort: ""

    property string userName: ""
    property string password: ""

    // Resolucion de pantalla
    minimumWidth: 800
    minimumHeight: 600

    // Modo de pantalla
    visible: true
    //visibility: Window.FullScreen

    title: "Control de usuario"

    GUISCPAManager {
        id: guiSCPAManager

        // Eventos del cliente TCP/IP
        // Conexion al servidor
        onClientConnected: {
            stackView.push(hmiLogin);
        }

        // Error de conexión al servidor
        onClientErrorConnected: {
            hmiDialogClientErrorConnected.open();
        }

        // Desconexión del servidor
        onClientDisconnected: {
            hmiDialogClientDisconnected.open();

            stackView.pop(null);
        }

        // Error de desconexión
        onClientErrorDisconnected: {
            hmiDialogErrorClientDisconnected.open();

            stackView.pop(null);
        }

        // Eventos de Login
        // Login correcto
        onLoginCorrect: {
            hmiDialogLoginCorrect.userName = applicationWindow.userName;
            hmiDialogLoginCorrect.open();

            stackView.push(hmiSCPATop);
        }

        // Ya hay otro usuario conectado
        onLoginForceRequired: {
            hmiDialogLoginForceRequired.open();
        }

        // Error de logeo
        onLoginError: {
            hmiDialogLoginError.userName = applicationWindow.userName;
            hmiDialogLoginError.open();

            hmiDialogLoginError.open();
        }

        // Eventos de desconexión por parte del servidor
        // Se desconecto por timeout
        onLoginTimeOut: {
            hmiDialogLoginTimeOut.open();

            stackView.pop(null);
        }

        // Un nuevo usuario inicio sesión
        onOtherUserLogin: {
            hmiDialogOtherUserLogin.open();

            stackView.pop(null);
        }
    }

    // Stackview
    StackView {
        id: stackView

        width: parent.width
        height: parent.height

        initialItem: hmiConnect
    }

    // Dialogos
    HMIDialogClientErrorConnected {
        id: hmiDialogClientErrorConnected
    }

    HMIDialogClientDisconnected {
        id: hmiDialogClientDisconnected
    }

    HMIDialogClientErrorDisconnected {
        id: hmiDialogErrorClientDisconnected
    }

    HMIDialogLoginCorrect {
        id: hmiDialogLoginCorrect
    }

    HMIDialogLoginForceRequired {
        id: hmiDialogLoginForceRequired

        // Si se desea iniciar sesión de todos modos
        onAccepted: {
            guiSCPAManager.sendForceLogin(true);
        }

        // Si no se desea iniciar sesión
        onRejected: {
            guiSCPAManager.sendForceLogin(false);

            guiSCPAManager.hmiDisconnect();
        }
    }

    HMIDialogLoginError {
        id: hmiDialogLoginError
    }

    HMIDialogLoginTimeOut {
        id: hmiDialogLoginTimeOut
    }

    HMIDialogOtherUserLogin {
        id: hmiDialogOtherUserLogin
    }

    // Paginas
    Component {
        id: hmiConnect

        HMIConnect {
            buttonClose.onClicked: {
                Qt.quit();
            }

            buttonConnect.onClicked: {
                applicationWindow.serverIP = textFieldServerIP.text;
                applicationWindow.serverPort = textFieldServerPort.text;

                guiSCPAManager.connectToServer(textFieldServerIP.text, textFieldServerPort.text);
            }
        }
    }

    Component {
        id: hmiLogin

        HMILogin {
            buttonDisconnect.onClicked: {
                guiSCPAManager.disconnectToServer();
            }

            buttonLogin.onClicked: {
                applicationWindow.userName = textFieldUserName.text;
                applicationWindow.password = textFieldPassword.text;

                guiSCPAManager.loginToServer(textFieldUserName.text, textFieldPassword.text);
            }
        }
    }

    Component {
        id: hmiSCPATop

        HMISCPATop {
            Component.onCompleted: {
                hMISCPAVariableIndicatorLvFoso.currentValue = guiSCPAManager.sensorLvFoso;
                hMISCPAVariableIndicatorLvLodo.currentValue = guiSCPAManager.sensorLvLodo;
                hMISCPAVariableIndicatorTemp.currentValue = guiSCPAManager.sensorTemp;
                hMISCPAVariableIndicatorOD.currentValue = guiSCPAManager.sensorOD;
                hMISCPAVariableIndicatorPHAnox.currentValue = guiSCPAManager.sensorPhAnox;
                hMISCPAVariableIndicatorPHAireacion.currentValue = guiSCPAManager.sensorPhAireacion;
            }

            buttonDisconnect.onClicked: {
                guiSCPAManager.disconnectToServer();
            }

            buttonSopladores.onClicked: {
                stackView.push(hmiSCPASopladores);
            }

            buttonSimulacion.onClicked: {
                stackView.push(hmiSCPASimulacion);
            }

            Timer {
                id: timer2
                interval: 300
                repeat: true
                running: true

                onTriggered: {
                    parent.hMISCPAVariableIndicatorLvFoso.currentValue = guiSCPAManager.sensorLvFoso;
                    parent.hMISCPAVariableIndicatorLvLodo.currentValue = guiSCPAManager.sensorLvLodo;
                    parent.hMISCPAVariableIndicatorTemp.currentValue = guiSCPAManager.sensorTemp;
                    parent.hMISCPAVariableIndicatorOD.currentValue = guiSCPAManager.sensorOD;
                    parent.hMISCPAVariableIndicatorPHAnox.currentValue = guiSCPAManager.sensorPhAnox;
                    parent.hMISCPAVariableIndicatorPHAireacion.currentValue = guiSCPAManager.sensorPhAireacion;
                }
            }
        }
    }

    Component {
        id: hmiSCPASopladores

        HMISCPASopladores {
            Component.onCompleted: {
                switchStateSystem.checked = guiSCPAManager.stateSystemActive;

                hMISCPAMotorStatusM01.motorOn = guiSCPAManager.stateSystemActive;
                hMISCPAMotorStatusM01.hMICircularProgressBarCorriente.currentValue = guiSCPAManager.sensorMotorCurrent;
                hMISCPAMotorStatusM01.hMICircularProgressBarVoltaje.currentValue = guiSCPAManager.sensorMotorVoltaje;
                hMISCPAMotorStatusM01.hMICircularProgressBarVelocidad.currentValue = guiSCPAManager.sensorMotorVelocity;
            }

            buttonVolver.onClicked: {
                stackView.pop();
            }

            switchStateSystem.onCheckedChanged: {
                switchStateSystem.checked ? guiSCPAManager.initSystem() : guiSCPAManager.stopSystem();
            }

            Timer {
                id: timer
                interval: 300
                repeat: true
                running: true

                onTriggered: {
                    parent.hMISCPAMotorStatusM01.motorOn = guiSCPAManager.stateSystemActive;
                    parent.hMISCPAMotorStatusM01.hMICircularProgressBarCorriente.currentValue = guiSCPAManager.sensorMotorCurrent;
                    parent.hMISCPAMotorStatusM01.hMICircularProgressBarVoltaje.currentValue = guiSCPAManager.sensorMotorVoltaje;
                    parent.hMISCPAMotorStatusM01.hMICircularProgressBarVelocidad.currentValue = guiSCPAManager.sensorMotorVelocity;
                }
            }
        }
    }

    Component {
        id: hmiSCPASimulacion

        HMISCPASimulacion {
            Component.onCompleted: {
                sliderLvFoso.value = guiSCPAManager.sensorLvFoso;
                sliderLvLodo.value = guiSCPAManager.sensorLvLodo;
                sliderTemp.value = guiSCPAManager.sensorTemp;
                sliderPhAnox.value = guiSCPAManager.sensorPhAnox;
                sliderPhAireacion.value = guiSCPAManager.sensorPhAireacion;

                sliderSetPointOD.value = guiSCPAManager.stateSetpointOD;
            }

            buttonSetLvFoso.onClicked: {
                guiSCPAManager.setLvFoso(sliderLvFoso.value);
            }

            buttonSetLvLodo.onClicked: {
                guiSCPAManager.setLvLodo(sliderLvLodo.value);
            }

            buttonSetTemp.onClicked: {
                guiSCPAManager.setTemp(sliderTemp.value);
            }

            buttonSetPHAnox.onClicked: {
                guiSCPAManager.setPhAnox(sliderPhAnox.value);
            }

            buttonSetPHAireacion.onClicked: {
                guiSCPAManager.setPhAireacion(sliderPhAireacion.value);
            }

            buttonSetSetPointOD.onClicked: {
                guiSCPAManager.setSetPointOD(sliderSetPointOD.value);
            }

            buttonVolver.onClicked: {
                stackView.pop();
            }
        }
    }
}
