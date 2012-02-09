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
