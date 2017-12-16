/*
 * Copyright 2013  Bhushan Shah <bhush94@gmail.com>
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
 * Copyright 2014 Kai Uwe Broulik <kde@privat.broulik.de>
 * Copyright 2014 Jeremy Whiting <jpwhiting@kde.org>
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
import QtQuick.Layouts 1.0 as QtLayouts
import QtQuick.Dialogs 1.2 as QtDialogs
import org.kde.kquickcontrols 2.0 as KQC

Item {
    id: appearancePage
    width: childrenRect.width
    height: childrenRect.height

    property alias cfg_indicatorType: indicatorTypeBox.indicatorType
    property alias cfg_boardSize: sizeSpinBox.value
    property alias cfg_boardColor: pieceColorPicker.color
    property alias cfg_numberColor: numberColorPicker.color
    property alias cfg_showNumerals: showNumeralsCheckBox.checked

    property alias cfg_useImage: useImageCheckBox.checked
    property alias cfg_imagePath: imagePathTextField.text

    QtLayouts.ColumnLayout {
        QtControls.GroupBox {
            title: i18n("Appearance")
            flat: true

            QtLayouts.GridLayout {
                columns: 2
                anchors.left: parent.left
                anchors.leftMargin: units.largeSpacing

                QtControls.Label {
                    text: i18n("Indicator type")
                }

                QtControls.ComboBox {
                    id: indicatorTypeBox
                    property string indicatorType: "Circle"
                    currentIndex: 0
                    model: ListModel {
                        id: cbItems
                        ListElement { text: "Circle"}
                        ListElement { text: "Desktop name"}
                        ListElement { text: "Custom label"}
                    }

                    onCurrentIndexChanged:
                    {
                        indicatorType = cbItems.get(currentIndex).text
                        /* console.debug(cbItems.get(currentIndex).text) */
                    }
                }

                QtControls.ExclusiveGroup {
                    id: plainPiecesGroup
                }

                QtControls.Label {
                    text: i18n("Size")
                    QtLayouts.Layout.alignment: Qt.AlignRight
                }

                QtControls.SpinBox {
                    id: sizeSpinBox
                }

                QtControls.Label {
                    text: i18n("Piece color")
                    QtLayouts.Layout.alignment: Qt.AlignRight
                }

                KQC.ColorButton {
                    id: pieceColorPicker
                }

                QtControls.Label {
                    text: i18n("Number color")
                    QtLayouts.Layout.alignment: Qt.AlignRight
                }

                KQC.ColorButton {
                    id: numberColorPicker
                }

                QtControls.CheckBox {
                    id: useImageCheckBox
                    text: i18n("Use custom image")
                    QtLayouts.Layout.alignment: Qt.AlignRight
                }

                QtLayouts.RowLayout {
                    QtControls.TextField {
                        id: imagePathTextField
                        QtLayouts.Layout.fillWidth: true
                        QtLayouts.Layout.minimumWidth: units.gridUnit * 10
                        placeholderText: i18n("Path to custom image")
                        onTextChanged: useImageCheckBox.checked = true
                    }

                    QtControls.Button {
                        iconName: "document-open"
                        tooltip: i18n("Browse...")

                        onClicked: imagePicker.open()

                        QtDialogs.FileDialog {
                            id: imagePicker

                            title: i18n("Choose an image")

                            folder: shortcuts.pictures

                            // TODO ask QImageReader for supported formats
                            nameFilters: [ i18n("Image Files (*.png *.jpg *.jpeg *.bmp *.svg *.svgz)") ]

                            onFileUrlChanged: {
                                imagePathTextField.text = fileUrl.toString().replace("file://", "")
                            }
                        }
                    }
                }

                QtControls.CheckBox {
                    id: showNumeralsCheckBox
                    QtLayouts.Layout.columnSpan: 2
                    text: i18n("Show numerals")
                }
            }
        }
    }
}
