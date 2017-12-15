/********************************************************************
Copyright 2016  Eike Hein <hein.org>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the
Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .
*********************************************************************/

#ifndef PAGERMODEL_H
#define PAGERMODEL_H

#include <config-X11.h>

#if HAVE_X11
#include <netwm.h>
#include <QX11Info>
#endif

#include <qwindowdefs.h>
#include <QAbstractListModel>
#include <QQmlParserStatus>

class QMimeData;

class PagerModel : public QAbstractListModel, public QQmlParserStatus
{
    Q_OBJECT

    Q_INTERFACES(QQmlParserStatus)

    Q_ENUMS(PagerType)
    Q_ENUMS(AdditionalRoles)

    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)
    Q_PROPERTY(PagerType pagerType READ pagerType WRITE setPagerType NOTIFY pagerTypeChanged)
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(bool shouldShowPager READ shouldShowPager NOTIFY shouldShowPagerChanged);
    Q_PROPERTY(bool showDesktop READ showDesktop WRITE setShowDesktop NOTIFY showDesktopChanged)
    Q_PROPERTY(bool showOnlyCurrentScreen READ showOnlyCurrentScreen WRITE setShowOnlyCurrentScreen NOTIFY showOnlyCurrentScreenChanged)
    Q_PROPERTY(QRect screenGeometry READ screenGeometry WRITE setScreenGeometry NOTIFY screenGeometryChanged)
    Q_PROPERTY(int currentPage READ currentPage NOTIFY currentPageChanged)
    Q_PROPERTY(int layoutRows READ layoutRows NOTIFY layoutRowsChanged)
    Q_PROPERTY(QSize pagerItemSize READ pagerItemSize NOTIFY pagerItemSizeChanged)

public:
    enum PagerType {
        VirtualDesktops = 0,
        Activities
    };

     enum AdditionalRoles {
         TasksModel = Qt::UserRole + 1
     };

    explicit PagerModel(QObject *parent = nullptr);
    virtual ~PagerModel();

    QHash<int, QByteArray> roleNames() const override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    PagerType pagerType() const;
    void setPagerType(PagerType type);

    bool enabled() const;
    void setEnabled(bool enabled);

    bool shouldShowPager() const;

    bool showDesktop() const;
    void setShowDesktop(bool show);

    bool showOnlyCurrentScreen() const;
    void setShowOnlyCurrentScreen(bool show);

    QRect screenGeometry() const;
    void setScreenGeometry(const QRect &geometry);

    int currentPage() const;

    int layoutRows() const;
    QSize pagerItemSize() const;

#if HAVE_X11
    QList<WId> stackingOrder() const;
#endif

    Q_INVOKABLE void refresh();

    Q_INVOKABLE void moveWindow(int window, double x, double y, int targetItemId, int sourceItemId,
        qreal widthScaleFactor, qreal heightScaleFactor);
    Q_INVOKABLE void changePage(int page);
    Q_INVOKABLE void drop(QMimeData *mimeData, int itemId);
    Q_INVOKABLE void addDesktop();
    Q_INVOKABLE void removeDesktop();

    void classBegin() Q_DECL_OVERRIDE;
    void componentComplete() Q_DECL_OVERRIDE;

Q_SIGNALS:
    void countChanged() const;
    void pagerTypeChanged() const;
    void enabledChanged() const;
    void shouldShowPagerChanged() const;
    void showDesktopChanged() const;
    void showOnlyCurrentScreenChanged() const;
    void screenGeometryChanged() const;
    void currentPageChanged() const;
    void layoutRowsChanged() const;
    void pagerItemSizeChanged() const;

private:
    class Private;
    QScopedPointer<Private> d;
};

#endif
