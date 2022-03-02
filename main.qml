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

            buttonDisconnect.onClicked: {
                guiSCPAManager.disconnectToServer();
            }

            buttonSopladores.onClicked: {
                stackView.push(hmiSCPASopladores);
            }

            buttonSimulacion.onClicked: {
                stackView.push(hmiSCPASimulacion);
            }

            hMISCPAVariableIndicatorLvFoso.currentValue: guiSCPAManager.lvFoso
            hMISCPAVariableIndicatorLvLodo.currentValue: guiSCPAManager.lvLodo
            hMISCPAVariableIndicatorTemp.currentValue: guiSCPAManager.temp
            hMISCPAVariableIndicatorOD.currentValue: guiSCPAManager.od
            hMISCPAVariableIndicatorPHAnox.currentValue: guiSCPAManager.phAnox
            hMISCPAVariableIndicatorPHAireacion.currentValue: guiSCPAManager.phAireacion
        }
    }

    Component {
        id: hmiSCPASopladores

        HMISCPASopladores {
            buttonVolver.onClicked: {
                stackView.pop()
            }

            switchStateSystem.onCheckedChanged: {
                switchStateSystem.checked ? guiSCPAManager.initSystem() : guiSCPAManager.stopSystem();
            }

            hMISCPAMotorStatusM01.hMICircularProgressBarCorriente.currentValue: guiSCPAManager.motorCurrent
            hMISCPAMotorStatusM01.hMICircularProgressBarVoltaje.currentValue: guiSCPAManager.motorVoltaje
            hMISCPAMotorStatusM01.hMICircularProgressBarVelocidad.currentValue: guiSCPAManager.motorVelocity
        }
    }

    Component {
        id: hmiSCPASimulacion

        HMISCPASimulacion {
            Component.onCompleted: {
                sliderLvFoso.value = guiSCPAManager.lvFoso;
                sliderLvLodo.value = guiSCPAManager.lvLodo;
                sliderTemp.value = guiSCPAManager.temp;
                sliderOD.value = guiSCPAManager.od;
                sliderPHAnox.value = guiSCPAManager.phAnox;
                sliderPHAireacion.value = guiSCPAManager.phAireacion;
            }

            buttonSetLvFoso.onClicked: {
                guiSCPAManager.setParam(0x00, sliderLvFoso.value);
            }

            buttonSetLvLodo.onClicked: {
                guiSCPAManager.setParam(0x01, sliderLvLodo.value);
            }

            buttonSetTemp.onClicked: {
                guiSCPAManager.setParam(0x02, sliderTemp.value);
            }

            buttonSetOD.onClicked: {
                guiSCPAManager.setParam(0x03, sliderOD.value);
            }

            buttonSetPHAnox.onClicked: {
                guiSCPAManager.setParam(0x04, sliderPHAnox.value);
            }

            buttonSetPHAireacion.onClicked: {
                guiSCPAManager.setParam(0x05, sliderPHAireacion.value);
            }

            buttonVolver.onClicked: {
                stackView.pop()
            }
        }
    }
}
