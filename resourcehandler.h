/*

Copyright (C) 2012 Francesco Balestrieri

This file is part of Interval Timer for N9

Interval Timer for N9 is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Interval Timer for N9 is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Interval Timer for N9.  If not, see <http://www.gnu.org/licenses/>.

*/


#ifndef RESOURCEHANDLER_H
#define RESOURCEHANDLER_H

#include <QObject>
#include <policy/resource-set.h>

class ResourceHandler : public QObject
{
    Q_OBJECT
public:
    explicit ResourceHandler(QObject *parent = 0);

signals:
    void acquired();

public slots:

    void acquire();
    void release();

    void resourceAcquired(QList<ResourcePolicy::ResourceType>);
    void resourceDenied() { qDebug() << "resource denied"; }
    void resourceLost() { qDebug() << "resource lost"; }
    void resourceReleased() { qDebug() << "resource released"; }
    void releasedByManager() { qDebug() << "released by manager"; }
    void resourceAvailable(const QList< ResourcePolicy::ResourceType > &r) { Q_UNUSED(r); qDebug() << "resource available"; }
    void onError (quint32 e, const char *t) { qDebug() << "error " << e << "/" << t; }

private:
    ResourcePolicy::ResourceSet* m_set;
};

#endif // RESOURCEHANDLER_H
