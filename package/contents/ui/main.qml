import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.pager 2.0

Item {
    id: main
    /* PlasmaComponents.Label { */
    /*     Layout.minimumWidth : plasmoid.formFactor == PlasmaCore.Types.Horizontal ? height : 1 */
    /*     Layout.minimumHeight : plasmoid.formFactor == PlasmaCore.Types.Vertical ? width  : 1 */
    /*     text: "Hello world in Plasma 5 "; */
    /* } */

    // from thermal monitor widget
    FontLoader {
        source: '../../../fonts/fontawesome-webfont-4.3.0.ttf'
    }
    GridLayout {
        id: desktopGrid

        Layout.minimumWidth: implicitWidth
        Layout.minimumHeight: implicitHeight
        flow: GridLayout.LeftToRight

        anchors.top: parent.top
        anchors.left: parent.left

        PagerModel {
            id: pagerModel

            showDesktop: true
            enabled: true

            /* showDesktop: (plasmoid.configuration.currentDesktopSelected == 1) */
            /* showOnlyCurrentScreen: plasmoid.configuration.showOnlyCurrentScreen */
            /* screenGeometry: plasmoid.screenGeometry */

            pagerType: PagerModel.VirtualDesktops
        }

        Repeater {
            id: desktopRepeater
            model: pagerModel

            /* hoverEnabled: true */
            /* columns: pagerColumns */

            /* readonly property int buttonIndex: index */
            readonly property int pagerColumns: {
                if (!pagerModel.count) {
                    return 1;
                }
                /* return Math.ceil(pagerModel.count / effectiveRows); */
                return pagerModel.count;
            }

            Rectangle {
                id: desktopBackground
                /* border.color: 'transparent' */
                border.color: 'green'
                /* width: appmenuButtonTitle.implicitWidth + units.smallSpacing * 3 */
                /* height: appmenuFillHeight ? appmenu.height : appmenuButtonTitle.implicitHeight + units.smallSpacing */
                /* color: menuOpened ? theme.highlightColor : 'transparent' */
                /* radius: units.smallSpacing / 2 */
            }  // end desktopBackground


            PlasmaComponents.Label {
                id: desktopLabel
                property int desktopId: index
                property bool active: (index == pagerModel.currentPage)
                font.family: 'FontAwesome'
                color: active ? theme.highlightColor : theme.textColor
                /* verticalAlignment: Text.AlignCenter */
                /* text: model.display */
                text: '\uf111'
                /* text: index + 1 */
                /* text: plasmoid.configuration.displayedText ? model.display : index + 1 */
                /* font.weight: appmenuFontBold ? Font.Bold : theme.defaultFont.weight */
            }  // end label
        } // end Repeater
    } // end desktopGrid
}
