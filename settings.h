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
