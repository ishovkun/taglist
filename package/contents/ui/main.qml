import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.pager 2.0

Rectangle {
/* MouseArea { */
    id: main
    color: "transparent"
    width: 400
    height: 400
    /* height: implicit */
    /* width: parent.width */
    /* width: Math.floor(height * 3) */
    /* color: "#333333" */

    // from thermal monitor widget
    FontLoader {
        source: '../../../fonts/fontawesome-webfont-4.3.0.ttf'
    }

    PagerModel {
        id: pagerModel
        showDesktop: true
        enabled: true
        pagerType: PagerModel.VirtualDesktops
    }

    GridLayout {
        id: desktopGrid

        Layout.minimumWidth: implicitWidth
        Layout.minimumHeight: implicitHeight
        // this should be if text then lefttoright else center (not necessary)
        flow: GridLayout.LeftToRight

        anchors.top: parent.top
        anchors.left: parent.left


        Repeater {
            id: desktopRepeater
            model: pagerModel

            Rectangle {
                id: desktopBackground
                border.color: 'transparent'
                width: desktopLabel.implicitWidth
                height: desktopLabel.implicitHeight + units.smallSpacing
                /* height: 40 */
                visible: true
                color: "green"
                property int desktopId: index
                property bool active: (index == pagerModel.currentPage)
                property bool hovered: false

                MouseArea {
                    id: desktopMouseArea
                    anchors.fill: parent
                    width: parent.width
                    hoverEnabled : true
                    /* onClicked: pagerModel.changePage(desktopId); */
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
                    /* verticalAlignment: Text.AlignCenter */
                    /* text: model.display */
                    text: '\uf111'
                    /* text: index + 1 */
                    /* text: plasmoid.configuration.displayedText ? model.display : index + 1 */
                }  // end label
                }  // end desktopBackground


            /* } //end tooltip */
        } // end Repeater
    } // end desktopGrid
}
