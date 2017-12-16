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

    FontLoader {
        source: '../../fonts/fontawesome-webfont-4.3.0.ttf'
    }

    PagerModel {
        id: pagerModel
        showDesktop: true
        enabled: true
        pagerType: PagerModel.VirtualDesktops
    }

    GridLayout {
        id: desktopGrid
        /* rows: 1 */
        Layout.minimumWidth : width + spacing
        Layout.minimumHeight: implicitHeight

        /* Layout.fillWidth: root.vertical */
        // this should be if text then lefttoright else center (not necessary)
        /* flow: GridLayout.LeftToRight */

        /* anchors.top: parent.top */
        /* anchors.left: parent.left */
        anchors.centerIn: parent
        /* anchors.rightMargin: spacing */
        /* anchors.fill: parent */

        Row {
            id: desktopRow
            spacing: 5
            anchors.rightMargin: spacing
            /* width: (desktopRepeater.count+1)*desktopBackground.width */

            Repeater {
                id: desktopRepeater
                model: pagerModel
                /* anchors.centerIn: parent */

                Rectangle {
                    id: desktopBackground
                    border.color: "transparent"
                    /* border.color: "green" */
                    color: "transparent"
                    width: desktopLabel.implicitWidth
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
                            if (active)
                                return theme.highlightColor
                            else {
                                if (hovered)
                                    return theme.highlightColor
                                else
                                    return theme.textColor
                            }
                        }

                        /* text: model.display */
                        text: '\uf111'
                        /* text: index + 1 */

                    }  // end label
                }  // end desktopBackground
            } // end row
        } // end Repeater
    } // end desktopGrid
}
