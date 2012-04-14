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
