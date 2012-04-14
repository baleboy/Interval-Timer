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


#include "settings.h"

#include <QSettings>

#define ROUNDS_NAME "rounds"
#define WORKTIMEMIN_NAME "workTimeMin"
#define BREAKTIMEMIN_NAME "breakTimeMin"
#define WORKTIMESEC_NAME "workTimeSec"
#define BREAKTIMESEC_NAME "breakTimeSec"
#define SOUNDS_NAME "sounds"
#define VIBRA_NAME "vibra"

#define ROUNDS_DEFAULT 5
#define WORKTIMEMIN_DEFAULT 2
#define WORKTIMESEC_DEFAULT 0
#define BREAKTIMEMIN_DEFAULT 0
#define BREAKTIMESEC_DEFAULT 10
#define SOUNDS_DEFAULT 0
#define VIBRA_DEFAULT true

Settings::Settings(QObject *parent) :
    QObject(parent)
{
    m_settings = new QSettings("balenet", "circuittimer");
}

Settings::~Settings()
{
    delete m_settings;
}


int Settings::rounds()
{
    return m_settings->value(ROUNDS_NAME, ROUNDS_DEFAULT).toInt();
}

int Settings::workTimeMin()
{
    return m_settings->value(WORKTIMEMIN_NAME, WORKTIMEMIN_DEFAULT).toInt();
}

int Settings::breakTimeMin()
{
    return m_settings->value(BREAKTIMEMIN_NAME, BREAKTIMEMIN_DEFAULT).toInt();
}

int Settings::workTimeSec()
{
    return m_settings->value(WORKTIMESEC_NAME, WORKTIMESEC_DEFAULT).toInt();
}

int Settings::breakTimeSec()
{
    return m_settings->value(BREAKTIMESEC_NAME, BREAKTIMESEC_DEFAULT).toInt();
}

void  Settings::setRounds(int rounds)
{
    m_settings->setValue(ROUNDS_NAME, QVariant(rounds));
    emit roundsChanged(rounds);
}

void Settings::setWorkTimeMin(int min)
{
    m_settings->setValue(WORKTIMEMIN_NAME, QVariant(min));
    emit workTimeChanged(workTime());
}

void Settings::setBreakTimeMin(int min)
{
    m_settings->setValue(BREAKTIMEMIN_NAME, QVariant(min));
    emit breakTimeChanged(breakTime());
}


void Settings::setWorkTimeSec(int sec)
{
    m_settings->setValue(WORKTIMESEC_NAME, QVariant(sec));
    emit workTimeChanged(workTime());
}

void Settings::setBreakTimeSec(int sec)
{
    m_settings->setValue(BREAKTIMESEC_NAME, QVariant(sec));
    emit breakTimeChanged(breakTime());
}

int Settings::workTime()
{
    return workTimeMin() * 60 + workTimeSec();
}

int Settings::breakTime()
{
    return breakTimeMin() * 60 + breakTimeSec();
}


int Settings::sounds()
{
    return m_settings->value(SOUNDS_NAME, SOUNDS_DEFAULT).toInt();
}

void  Settings::setSounds(int i)
{
    m_settings->setValue(SOUNDS_NAME, QVariant(i));
    emit soundsChanged(i);
}

bool Settings::vibra()
{
    return m_settings->value(VIBRA_NAME, VIBRA_DEFAULT).toBool();
}

void  Settings::setVibra(bool b)
{
    m_settings->setValue(VIBRA_NAME, QVariant(b));
    emit vibraChanged(b);
}
