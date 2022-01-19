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

    GUISCPAManager {
        id: guiSCPAManager

        // Eventos del cliente TCP/IP
        // Conexion al servidor
        onClientConnected: {

        }

        // Error de conexión al servidor
        onClientErrorConnected: {
            hmiDialogClientErrorConnected.open();
        }

        // Desconexión del servidor
        onClientDisconnected: {
            hmiDialogClientDisconnected.open();
        }

        // Error de desconexión
        onClientErrorDisconnected: {
            hmiDialogErrorClientDisconnected.open();
        }

        // Eventos de Login
        // Login correcto
        onLoginCorrect: {
            hmiDialogLoginCorrect.open();
        }

        // Ya hay otro usuario conectado
        onLoginForceRequired: {
            hmiDialogLoginForceRequired.open();
        }

        // Error de logeo
        onLoginError: {
            hmiDialogLoginError.open();
        }

        // Eventos de desconexión por parte del servidor
        // Se desconecto por timeout
        onLoginTimeOut: {
            hmiDialogLoginTimeOut.open();
        }

        // Un nuevo usuario inicio sesión
        onOtherUserLogin: {
            hmiDialogOtherUserLogin.open();
        }
    }

    // Stackview
    StackView {
        id: stackView

        width: parent.width
        height: parent.height

        initialItem: PageConnect {
            id: pageConnect

            width: stackView.width
            height: stackView.height
        }
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
}
