#include "resourcehandler.h"

#define RESOURCE_CLASS "alarm"

ResourceHandler::ResourceHandler(QObject *parent) :
    QObject(parent)
{
    m_set = new ResourcePolicy::ResourceSet(RESOURCE_CLASS, this);

    ResourcePolicy::AudioResource* audioResource = new ResourcePolicy::AudioResource("alarm");
    audioResource->setProcessID(QCoreApplication::applicationPid());
    audioResource->setStreamTag("event.id", "alarm-clock-elapsed");
    m_set->addResourceObject(audioResource);

    QObject::connect(m_set, SIGNAL(resourcesGranted(QList<ResourcePolicy::ResourceType>)), this, SLOT(resourceAcquired(QList<ResourcePolicy::ResourceType>)));
    QObject::connect(m_set, SIGNAL(resourcesDenied()), this, SLOT(resourceDenied()));
    QObject::connect(m_set, SIGNAL(lostResources()), this, SLOT(resourceLost()));
    QObject::connect(m_set, SIGNAL(resourcesReleased()), this, SLOT(resourceReleased()));
    QObject::connect(m_set, SIGNAL(errorCallback (quint32, const char *)), this, SLOT(onError(quint32,const char*)));
    QObject::connect(m_set, SIGNAL(resourcesReleasedByManager()), this, SLOT(releasedByManager()));
    QObject::connect(m_set, SIGNAL(resourcesBecameAvailable(const QList< ResourcePolicy::ResourceType > &	 )),
                     this, SLOT(resourceAvailable(const QList< ResourcePolicy::ResourceType > &)));

    m_set->initAndConnect();
}

void ResourceHandler::resourceAcquired(QList<ResourcePolicy::ResourceType> resources)
{
    Q_UNUSED(resources);
    qDebug() << "resource acquired";
    emit acquired();
}

void ResourceHandler::acquire()
{
    m_set->acquire();
}

void ResourceHandler::release(){
    m_set->release();
}
