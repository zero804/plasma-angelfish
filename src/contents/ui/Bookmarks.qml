/***************************************************************************
 *                                                                         *
 *   Copyright 2014-2015 Sebastian Kügler <sebas@kde.org>                  *
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
 *                                                                         *
 ***************************************************************************/

import QtQuick 2.3
import QtQuick.Layouts 1.0

import org.kde.kirigami 2.0 as Kirigami


Item {
//    id: options

    //Rectangle { anchors.fill: parent; color: "orange"; opacity: 0.5; }
    anchors.fill: parent

    ListView {

        anchors.fill: parent

        spacing: Kirigami.Units.smallSpacing
        interactive: height < contentHeight
        clip: false

        model: browserManager.bookmarks

        delegate: UrlDelegate {
            onRemoved: browserManager.removeBookmark(url);
        }
    }
    Component.onCompleted: print("Bookmarks.qml complete.");

}