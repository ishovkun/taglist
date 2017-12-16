import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.pager 2.0

Rectangle {
    id: root
    color: "transparent"
    width: desktopRow.width
    height: parent == null ? desktopGrid.implicitHeight : parent.height

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    Layout.preferredWidth: desktopRow.width
    Layout.minimumWidth : desktopRow.width
    Layout.minimumHeight: desktopRepeater.implicitHeight
    Layout.maximumWidth : desktopRow.width

    property bool showDesktopName: false
    property bool showCustomLabel: false
    property bool showCircle: true

    FontLoader {
        /* source: '../../fonts/fontawesome-webfont-4.3.0.ttf' */
        source: '../../fonts/fontawesome-webfont.ttf'
    }

    PagerModel {
        id: pagerModel
        showDesktop: true
        enabled: true
        pagerType: PagerModel.VirtualDesktops
    }

    GridLayout {
        id: desktopGrid
        Layout.minimumWidth : width
        Layout.minimumHeight: implicitHeight

        // this should be if text then lefttoright else center (not necessary)
        /* flow: GridLayout.LeftToRight */

        anchors.centerIn: parent

        // Row fixes the thing with labels overlap
        Row {
            id: desktopRow
            /* spacing: units.smallSpacing*2 */
            spacing: 0

            Repeater {
                id: desktopRepeater
                model: pagerModel
                /* anchors.centerIn: parent */

                Rectangle {
                    id: desktopBackground
                    border.color: "transparent"
                    /* border.color: "green" */
                    color: {
                        if (showCircle)
                            return "transparent"
                        else {
                            if (active || hovered)
                                return theme.highlightColor
                            else
                                return "transparent"
                        }
                    }

                    width: desktopLabel.implicitWidth + units.smallSpacing*2
                    height: desktopLabel.implicitHeight + units.smallSpacing
                    visible: true
                    property int desktopId: index
                    property bool active: (index == pagerModel.currentPage)
                    property bool hovered: false

                    MouseArea {
                        id: desktopMouseArea
                        anchors.fill: parent
                        width: parent.width
                        hoverEnabled : true
                        onEntered: {
                            hovered = true;
                        }
                        onExited: {
                            hovered = false;
                        }
                        onClicked: {
                            /* console.log("clicked") */
                            if (active == false)
                                onClicked: pagerModel.changePage(desktopId);
                        }

                    } // end desktopMouseArea

                    PlasmaComponents.Label {
                        id: desktopLabel
                        anchors.centerIn: parent
                        font.family: 'FontAwesome'

                        color: {
                            if (showCircle) {
                                if (active || hovered)
                                    return theme.highlightColor
                                else
                                    return theme.textColor
                            }
                            else
                                return theme.textColor
                        }

                        text: {
                            if (showCircle)
                                return '\uf111'
                            else if (showDesktopName)
                                return model.display
                            /* text: index + 1 */
                        }

                    }  // end label

                    PlasmaComponents.Label {
                        id: desktopBackgroundCircle
                        anchors.centerIn: parent
                        font.family: 'FontAwesome'

                        color: {
                                return theme.textColor
                        }

                        text: {
                            return '\uf268'
                        }

                    }  // end label
                }  // end desktopBackground
            } // end row
        } // end Repeater
    } // end desktopGrid
}
