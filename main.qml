import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Styles
import QtQuick.VirtualKeyboard.Settings

import GUISCPA

import "."
import "items"
import "pages"

ApplicationWindow {
    id: applicationWindow

    // Resolucion de pantalla
    width: 800
    height: 480

    // Modo de pantalla
    visible: true
    visibility: Window.Maximized

    title: "Control de usuario"

    HMIState {
        id: hmiState
    }

    GUISCPAManager {
        id: guiSCPAManager

        // Conexion con el servidor correcta
        onClientConnected: {
            guiSCPAManager.sendLogin(pageHome.userName, pageHome.password);
        }

        // Conexion desconectada
        onClientDisconnected: {
            if (hmiState.login) {
                hmiDialogClientDisconnect.open();
            }

            stackView.pop(null);

            // Establecemos los valor
            hmiState.login = false;
        }

        // Logeo correcto
        onLoginCorrect: {
            hmiDialogLoginCorrect.userName = pageHome.userName;
            hmiDialogLoginCorrect.open();

            stackView.push(componentPageSCPATop);

            // Establecemos los valor
            hmiState.login = true;
        }

        // Error de usuario o contraseña
        onLoginError: {
            hmiDialogLoginError.userName = pageHome.userName;
            hmiDialogLoginError.open();

            guiSCPAManager.hmiDisconnect();
        }
    }

    StackView {
        id: stackView

        width: parent.width
        height: parent.height

        initialItem: PageHome {
            id: pageHome

            width: stackView.width
            height: stackView.height

            HMIDialogClientDisconnect {
                id: hmiDialogClientDisconnect
            }

            HMIDialogLoginCorrect {
                id: hmiDialogLoginCorrect
            }

            HMIDialogLoginError {
                id: hmiDialogLoginError
            }
        }
    }

    Component {
        id: componentPageConnecting

        PageConnecting {
            id: pageConnecting

            width: stackView.width
            height: stackView.height
        }
    }

    Component {
        id: componentPageSCPATop

        PageSCPATop {
            id: pageSCPATop

            width: stackView.width
            height: stackView.height
        }
    }
}
