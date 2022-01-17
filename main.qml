import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Styles
import QtQuick.VirtualKeyboard.Settings

import GUISCPA

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

        // Conexion con el servidor correcta
        onClientConnected: {
            guiSCPAManager.sendLogin(pageHome.userName, pageHome.password);
        }

        // Conexion con el servidor fallida por problemas de red
        onClientFailConnected: {
            pageHome.connecting = false;
        }

        // Conexion correcta, logeo correcto
        onClientLoginConnected: {
            hmiDialogLoginCorrect.open();
            stackView.push(componentPageSCPATop);
        }

        // Conexion con el servidor erronea por logeo incorrecto
        onClientErrorConnected: {
            pageHome.connecting = false;
        }

        // Conexion con el servidor erronea por usuario ocupado
        onClientBusyConnected: {

        }

        // Conexion con el servidor erronea por dejar la sesion activa
        onClientPassConnected: {
            pageHome.connecting = false;
        }

        // Conexion con el servidor erronea por error desconocido
        onClientUndefinedErrorConnected: {
            pageHome.connecting = false;
        }

        // Conexion con el servidor desconectada
        onClientDisconnected: {
            pageHome.connecting = false;
        }
    }

    StackView {
        id: stackView

        width: parent.width
        height: parent.height

        Layout.alignment: Qt.AlignCenter

        initialItem: PageHome {
            id: pageHome

            HMIDialogLoginCorrect {
                id: hmiDialogLoginCorrect
            }
        }
    }

    Component {
        id: componentPageSCPATop

        PageSCPATop {
            id: pageSCPATop
        }
    }
}
