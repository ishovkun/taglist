/*
 * Copyright 2017  Igor Shovkun <igshov@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.pager 2.0
import org.kde.kquickcontrolsaddons 2.0 as KQuickControlsAddonsComponents

Rectangle {
    id: root
    color: "transparent"
    width: desktopRow.width
    height: parent == null ? desktopGrid.implicitHeight : parent.height

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    Layout.preferredWidth: desktopRow.width
    Layout.minimumWidth : desktopRow.width
    Layout.minimumHeight: desktopRepeater.implicitHeight

    property bool showDesktopName: false
    property bool showCustomLabel: false
    property bool showCircle: true
    property var customLabels

    function loadConfig() {
        var t = plasmoid.configuration.indicatorType
        if (t == "Circle") {
            showDesktopName = false
            showCustomLabel = false
            showCircle = true
        }
        else if (t == "Desktop name") {
            showDesktopName = true
            showCustomLabel = false
            showCircle = false

        }
        else if (t == "Custom labels") {
            showDesktopName = false
            showCustomLabel = true
            showCircle = false

        }
        /* if (showCustomLabel) { */
        /*     console.log("Showing custom labels") */
        var label_string = plasmoid.configuration.customLabels
        console.log(label_string)
        customLabels = label_string.split(',')
        /* } */
    }

    function action_openKCM() {
        KQuickControlsAddonsComponents.KCMShell.open("desktop");
    }

    Component.onCompleted: {
        loadConfig()
        plasmoid.setAction("openKCM", i18n("Configure Desktops..."), "configure");
    }

    Connections {
        target: plasmoid.configuration
        onIndicatorTypeChanged: {
            loadConfig()
        }
    }

    Connections {
        target: plasmoid.configuration
        onCustomLabelsChanged: {
            /* console.log("config changed") */
            loadConfig()
        }
    }

    FontLoader {
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
                            else if (showCustomLabel == true && customLabels.length > index)
                                return customLabels[index]
                            else {
                                return model.display
                            }
                            /* text: index + 1 */
                        }

                    }  // end label

                }  // end desktopBackground
            } // end row
        } // end Repeater
    } // end desktopGrid
}
