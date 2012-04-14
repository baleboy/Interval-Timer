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


#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>

class QSettings;

class Settings : public QObject
{
    Q_OBJECT

    Q_PROPERTY (int rounds READ rounds WRITE setRounds NOTIFY roundsChanged)
    Q_PROPERTY (int workTime READ workTime NOTIFY workTimeChanged)
    Q_PROPERTY (int breakTime READ breakTime NOTIFY breakTimeChanged)
    Q_PROPERTY (int workTime READ workTime NOTIFY workTimeChanged)
    Q_PROPERTY (int breakTime READ breakTime NOTIFY breakTimeChanged)

    Q_PROPERTY (int workTimeMin READ workTimeMin WRITE setWorkTimeMin NOTIFY workTimeChanged)
    Q_PROPERTY (int workTimeSec READ workTimeSec WRITE setWorkTimeSec NOTIFY workTimeChanged)

    Q_PROPERTY (int breakTimeMin READ breakTimeMin WRITE setBreakTimeMin NOTIFY breakTimeChanged)
    Q_PROPERTY (int breakTimeSec READ breakTimeSec WRITE setBreakTimeSec NOTIFY breakTimeChanged)

    Q_PROPERTY (int sounds READ sounds WRITE setSounds NOTIFY soundsChanged)

    Q_PROPERTY (bool vibra READ vibra WRITE setVibra NOTIFY vibraChanged)

public:
    explicit Settings(QObject *parent = 0);
    ~Settings();
    
signals:
    
    void roundsChanged(int value);
    void workTimeChanged(int value);
    void breakTimeChanged(int value);
    void soundsChanged(int value);
    void vibraChanged(bool value);

public slots:

    int rounds();
    void setRounds(int rounds);

    int workTime();
    int breakTime();

    int workTimeMin();
    int breakTimeMin();
    int workTimeSec();
    int breakTimeSec();
    int sounds();

    void setWorkTimeMin(int min);
    void setBreakTimeMin(int min);
    void setWorkTimeSec(int sec);
    void setBreakTimeSec(int sec);
    void setSounds(int i);

    bool vibra();
    void setVibra(bool b);


private:

    QSettings* m_settings;
};

#endif // SETTINGS_H
