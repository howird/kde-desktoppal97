import QtQuick 2.8
import QtQuick.Controls 2.8
import QtQuick.Controls 1.4 as Q1
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0
import "."
Rectangle {
    id : container
    LayoutMirroring.enabled : Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit : true
    property int sessionIndex : session.index
    TextConstants {
        id : textConstants
    }
    FontLoader {
        id : loginfont
        source : "NotoSans-Regular.ttf"
    }
    Connections {
        target : sddm
        onLoginSucceeded : {
            errorMessage.color = "green"
            errorMessage.text = textConstants.loginSucceeded
        }
        onLoginFailed : {
            password.text = ""
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
            errorMessage.bold = true
        }
    }
    color : "#7fbfaa"
    anchors.fill : parent

    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.Stretch
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    Image {
        anchors.centerIn : parent
        id : promptbox
        source : "promptbox.svg"
        width : 360
        height : 500

        Column {
            id : entryColumn
            anchors.horizontalCenter : parent.horizontalCenter
            anchors.verticalCenter : parent.verticalCenter
            spacing : 4
            topPadding : 30
            width: 310


          Image {
            id: logo
            anchors.horizontalCenter: parent.horizontalCenter
            source: "desktoppal97.svg"
            width: 244
            height: 244
            }


            Text {
                id : errorMessage
                text : textConstants.prompt
                font.pointSize : 10
                color : "#000000"
                font.family : loginfont.name
                bottomPadding : 2
                topPadding : 2
                anchors.horizontalCenter: parent.horizontalCenter
            }


            Row {
                anchors.right: parent.right
                spacing : 32
                Text {
                    id : lblLoginName
                    height : 32
                    width : 86
                    text : textConstants.userName
                    font.pointSize : 10
                    verticalAlignment : Text.AlignVCenter
                    color : "#000000"
                    font.family : loginfont.name

                }
                TextField {
                    id : name
                    font.family : loginfont.name
                    width : 180
                    height : 32
                    text : userModel.lastUser
                    font.pointSize : 10
                    color : "#000000"
                    background : Image {
                        source : name.focus ? "inputfocus.svg" : "input.svg"
                    }
                    KeyNavigation.tab : password
                    Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            password.focus = true
                            event.accepted = true
                        }
                    }
                }
            }
            Row {
                anchors.right: parent.right
                spacing : 32

                Text {
                    id : lblLoginPassword
                    height : 32
                    width : 86
                    text : textConstants.password
                    verticalAlignment : Text.AlignVCenter
                    color : "#000000"
                    font.pointSize : 10
                    font.family : loginfont.name
                }
                TextField {
                    id : password
                    font.pointSize : 10
                    echoMode : TextInput.Password
                    font.family : loginfont.name
                    color : "#000000"
                    width : 180
                    height : 32
                    background : Image {
                        source : password.focus ? "inputfocus.svg" : "input.svg"
                    }
                    KeyNavigation.backtab : name
                    KeyNavigation.tab : session
                    focus : true
                    Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, sessionIndex)
                            event.accepted = true
                        }
                    }
                }
            }

            Row {
                z: 1
                anchors.right: parent.right
                spacing : 32
                Text {
                    id : lblSession
                    height : 32
                    width : 86
                    text : textConstants.session
                    verticalAlignment : Text.AlignVCenter
                    color : "#000000"
                    font.pointSize : 10
                    font.family : loginfont.name

                }



Image{
    id: comboImg
    source: "input.svg"
    width : 180
    height : 32
                ComboBox {
            id : session
anchors.horizontalCenter: parent.horizontalCenter
anchors.verticalCenter: parent.verticalCenter

            color : "#c0dcc0"
            borderColor : "#4f5a55"
            hoverColor : "#00dfaa"
            focusColor : "#00dfaa"
            textColor : "#000000"
            menuColor : "#c0dcc0"
            width : 178
            height : 30
            font.pointSize : 10
            font.family : loginfont.name
            arrowIcon : "comboarrow.svg"
            model : sessionModel
            index : sessionModel.lastIndex
            KeyNavigation.backtab : password
            KeyNavigation.tab : loginButton

        }

            }
            }

Column{
    width: parent.width
    spacing: 4
    topPadding : 2


     Image {
                id : loginButton
                source : "buttonup3.svg"
         //   anchors.right : parent.right
       anchors.horizontalCenter: parent.horizontalCenter

        Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, sessionIndex)
                            event.accepted = true
                        }

                    }

                MouseArea {
                    anchors.fill : parent
                    hoverEnabled : true
                    onEntered : {
                        parent.source = "buttonhover3.svg"
                    }
                    onExited : {
                        parent.source = "buttonup3.svg"
                    }
                    onPressed : {
                        parent.source = "buttondown3.svg"

                    }
                    onReleased : {
                        parent.source = "buttonup3.svg"
                        sddm.login(name.text, password.text, sessionIndex)
                    }
                }

                Image {
    source : "login.svg"
    anchors.verticalCenter: parent.verticalCenter
    x: 5
}

Image {
    source : "buttonfocus3.svg"
    anchors.fill : parent
    visible : loginButton.focus

}

Rectangle{
    color: "#00000000"
    width: 130
    height: 30
    anchors.right : parent.right

                Text {
                    text : textConstants.login
                    anchors.centerIn : parent
                    font.family : loginfont.name
                    font.pointSize : 10
                    color : "#000000"
                }
}
                KeyNavigation.backtab : session
                KeyNavigation.tab : shutdownButton
            }


            Row{
                width : 236 //116+116+4
                height : 32
                 anchors.horizontalCenter: parent.horizontalCenter
                 spacing: 4


            Image {
            id : shutdownButton
            source : "buttonup.svg"
            //anchors.right: parent.right
            //anchors.bottom : parent.bottom

             Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.powerOff()
                            event.accepted = true
                        }

                    }


            MouseArea {
                anchors.fill : parent
                hoverEnabled : true
                onEntered : {
                    parent.source = "buttonhover.svg"
                }
                onExited : {
                    parent.source = "buttonup.svg"
                }
                onPressed : {
                    parent.source = "buttondown.svg"
                    sddm.powerOff()
                }
                onReleased : {
                    parent.source = "buttonup.svg"
                }
            }

            Image {
    source : "shutdown.svg"
    anchors.verticalCenter: parent.verticalCenter
    x: 5
}

Image {
    source : "buttonfocus.svg"
    anchors.fill : parent
    visible : shutdownButton.focus

}

Rectangle{
    color: "#00000000"
    width: 90
    height: 30
    anchors.right : parent.right

            Text {
                text : textConstants.shutdown
                anchors.centerIn : parent
                    font.family : loginfont.name
                    font.pointSize : 10
                    color : "#000000"
            }
}
            KeyNavigation.backtab : loginButton
            KeyNavigation.tab : rebootButton
        }
        Image {
            id : rebootButton
            source : "buttonup.svg"
            //anchors.left : parent.left
            //anchors.bottom : parent.bottom

            Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.reboot()
                            event.accepted = true
                        }
                    }

            MouseArea {
                anchors.fill : parent
                hoverEnabled : true
                onEntered : {
                    parent.source = "buttonhover.svg"
                }
                onExited : {
                    parent.source = "buttonup.svg"
                }
                onPressed : {
                    parent.source = "buttondown.svg"

                }
                onReleased : {
                    parent.source = "buttonup.svg"
                    sddm.reboot()
                }
            }

            Image {
    source : "restart.svg"
    anchors.verticalCenter: parent.verticalCenter
    x: 5

}

Image {
    source : "buttonfocus.svg"
    anchors.fill : parent
    visible : rebootButton.focus

}

Rectangle{
    color: "#00000000"
    width: 90
    height: 30
    anchors.right : parent.right

            Text {
                text : textConstants.reboot
                anchors.centerIn : parent
                    font.family : loginfont.name
                    font.pointSize : 10
                    color : "#000000"
            }
}
            KeyNavigation.backtab : shutdownButton
            KeyNavigation.tab : name
        }

        }



}

        }
    }
}
