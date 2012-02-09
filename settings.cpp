#include "settings.h"

#include <QSettings>

#define ROUNDS_NAME "rounds"
#define WORKTIMEMIN_NAME "workTimeMin"
#define BREAKTIMEMIN_NAME "breakTimeMin"
#define WORKTIMESEC_NAME "workTimeSec"
#define BREAKTIMESEC_NAME "breakTimeSec"
#define SOUNDS_NAME "sounds"

#define ROUNDS_DEFAULT 5
#define WORKTIMEMIN_DEFAULT 2
#define WORKTIMESEC_DEFAULT 0
#define BREAKTIMEMIN_DEFAULT 0
#define BREAKTIMESEC_DEFAULT 10
#define SOUNDS_DEFAULT 0

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
