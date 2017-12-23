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
import QtQuick.Controls 1.2 as QtControls
import QtQuick.Layouts 1.1
import QtQuick.Layouts 1.1 as QtLayouts
import QtQuick.Dialogs 1.2 as QtDialogs
import org.kde.kquickcontrols 2.0 as KQC


Item {
    id: appearancePage
    width: childrenRect.width
    height: childrenRect.height

    property alias cfg_indicatorType: indicatorTypeBox.currentIndex
    property alias cfg_customLabels: customLabels.text

    QtLayouts.ColumnLayout {
        width: appearancePage.width

        QtControls.GroupBox {
            width: appearancePage.width
            title: i18n("Appearance")
            flat: true
            anchors.fill: parent

            QtLayouts.GridLayout {
                columns: 2
                /* anchors.fill: parent */

                QtControls.Label {
                    text: i18n("Indicator type")
                    width: appearancePage.width/2
                }

                QtControls.ComboBox {
                    id: indicatorTypeBox
                    property string indicatorType: "Circle"
                    Layout.minimumWidth : appearancePage.width/2
                    currentIndex: 0
                    model: ListModel {
                        id: cbItems
                        ListElement { text: "Circle"}
                        ListElement { text: "Desktop name"}
                        ListElement { text: "Custom labels"}
                    }

                    onCurrentIndexChanged: {
                        indicatorType = cbItems.get(currentIndex).text
                        console.debug(currentIndex)
                    }
                    /* Component.onCompleted: { */
                    /*     for (i = 0; i < this.model.count; i++) */
                    /* } */
                }

                QtControls.Label {
                    text: i18n("Custom labels")
                    /* QtLayouts.Layout.alignment: Qt.AlignRight */
                }

                QtControls.TextField {
                    id: customLabels
                    Layout.minimumWidth : appearancePage.width/2
                    font.family: 'FontAwesome'
                    /* text: ", 2, 3, 4, 5, 6, 7" */
                    /* text: ", 2, 3, 4, 5, 6, 7" */
                    property string labelsValue: text

                    onTextChanged: {
                        console.debug(text)
                        /* labelsValue = displayText */
                        labelsValue = text
                    }
                }  // end custom Labels
            } // end qgridlayout
        }
    }
}
