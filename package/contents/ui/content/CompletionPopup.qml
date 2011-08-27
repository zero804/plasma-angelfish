/***************************************************************************
 *                                                                         *
 *   Copyright 2011 Sebastian Kügler <sebas@kde.org>                       *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick 1.0
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets
import org.kde.qtextracomponents 0.1

Item {
    width: 100
    height: 200
    objectName: "completionPopup"
    id: mainItem
    state: "expanded"

    PlasmaCore.Theme {
        id: theme
    }
    
    PlasmaCore.FrameSvgItem {
        id: frame

        anchors.fill: parent
        imagePath: "widgets/frame"
        prefix: "raised"
        /*
        PlasmaCore.DataSource {
            id: bookmarksSource
            engine: "org.kde.active.bookmarks"
            connectedSources: ["bookmarks"]

            onSourceAdded: {
                print("source added!" + source);
            }

            Component.onCompleted: {
                connectSource("all");
            }
        }
        */
        ListModel {
            id: myModel
            ListElement { type: "Dog"; age: 8 }
            ListElement { type: "Cat"; age: 5 }
        }

        Component {
            id: myDelegate
            Text {
                text: type + ", " + age
                color: theme.textColor
            }
        }

        ListView {
            anchors.fill: parent
            anchors.margins: 16
            y: 16
            spacing: 10
            model: myModel
            delegate: myDelegate
        }
    }
    

    Component.onCompleted: {
        print("completer loaded");
    }

    onVisibleChanged: {
        print("visibility changed to " + visible);
    }

    onStateChanged: {
        print("state changed: " + state);
    }


    states: [
        State {
            id: expanded
            name: "expanded";
            PropertyChanges {
                target: mainItem
                opacity: 1
            }
        },

        State {
            id: collapsed
            name: "collapsed";
            PropertyChanges {
                target: mainItem
                opacity: 0
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "opacity"
                duration: 400;
                easing.type: Easing.InOutElastic;
                easing.amplitude: 2.0; easing.period: 1.5
            }
        }
    ]

    
}