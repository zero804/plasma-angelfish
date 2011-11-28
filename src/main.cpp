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

// KDE
#include <KAboutData>
#include <KCmdLineArgs>
#include <KDebug>
#include <KService>
#include <KConfigGroup>

// Own
#include "activewebbrowser.h"

static const char description[] = I18N_NOOP("Web browser for Plasma Active");

static const char version[] = "1.9";
//static const char HOME_URL[] = "http://community.kde.org/Plasma/Active";
static const char HOME_URL[] = "";

int main(int argc, char **argv)
{
    KAboutData about("active-web-browser", 0, ki18n("Plasma Active Web Browser"), version, ki18n(description),
                     KAboutData::License_GPL, ki18n("Copyright 2011 Sebastian Kügler"), KLocalizedString(), 0, "sebas@kde.org");
                     about.addAuthor( ki18n("Sebastian Kügler"), KLocalizedString(), "sebas@kde.org" );
    KCmdLineArgs::init(argc, argv, &about);

    KService::Ptr service = KService::serviceByDesktopName("active-web-browser");
    const QString homeUrl = service ? service->property("X-KDE-PluginInfo-Website", QVariant::String).toString() : HOME_URL;
    KCmdLineOptions options;
    options.add("+[url]", ki18n( "URL to open" ), homeUrl.toLocal8Bit());
#ifndef QT_NO_OPENGL
    options.add("opengl", ki18n("use a QGLWidget for the viewport"));
#endif
    KCmdLineArgs::addCmdLineOptions(options);

    KCmdLineArgs *args = KCmdLineArgs::parsedArgs();

    ActiveWebbrowser app(args);

    bool useGL = args->isSet("opengl");

    if (!useGL) {
        //use plasmarc to share this with plasma-windowed
        KConfigGroup cg(KSharedConfig::openConfig("plasmarc"), "General");
        useGL = cg.readEntry("UseOpenGl", true);
    }
    const QString url = args->count() ? args->arg(0) : homeUrl;

    app.setUseGL(useGL);
    app.newWindow(url);
    args->clear();
    return app.exec();
}