import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:time_managment_app/src/core/utils/constants.dart';
import 'package:time_managment_app/src/domain/models/timer_status_model.dart';
import 'package:time_managment_app/src/presentation/widgets/button/custom_btn.dart';
import 'package:time_managment_app/src/presentation/widgets/progress_status/progress_status.dart';
import 'package:time_managment_app/src/presentation/widgets/shrake_transition/shrake_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const String _btnStartPomo = 'Start';
const Icon _startBtnIcon =
    Icon(color: Colors.white, size: 30, Icons.play_arrow_rounded);
const Icon _btnPauseIcon = Icon(color: Colors.white, size: 30, Icons.pause);
const String _enterStatus = 'Stay focus for 25 min';
const String _shortBreakStatus = 'Take a break for 5 min';
const String _longBreakStatus = 'Take a break for 15 min';

class _HomePageState extends State<HomePage> {
  String mainCurrentStatus = _enterStatus;
  int remaingTime = pomodoroTotalTime;
  String mainBtnText = _btnStartPomo;
  Icon mainBtnIcon = _startBtnIcon;
  PomodoroStatus pomodoroStatus = PomodoroStatus.pausedPomodoro;
  late Timer _timer;
  int pomodoNumber = 0;
  int setNumber = 0;

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      body: SafeArea(
        child: ShrakeTransition(
          axis: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text('Pomodoro timer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white70,
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 120,
                      lineWidth: 8.0,
                      percent: _getPomodoroPercentage(),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconDescription[pomodoroStatus] as Icon,
                          const SizedBox(height: 40),
                          Text(
                            _secsToFormatedString(remaingTime),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            mainCurrentStatus,
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      progressColor: statusColor[pomodoroStatus],
                    ),
                    const SizedBox(height: 40),
                    ShrakeTransition(
                      offset: -140.0,
                      duration: const Duration(milliseconds: 500),
                      child: ProgressStatus(
                        done: pomodoNumber - (setNumber * pomodoroPerSet),
                        total: pomodoroPerSet,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('$pomodoNumber/$pomodoroPerSet sections',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ShrakeTransition(
                        duration: const Duration(milliseconds: 500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBtn(
                              borderColor:
                                  const Color.fromARGB(239, 39, 53, 176),
                              color: Colors.transparent,
                              icon: const Icon(
                                Icons.replay,
                                color: Color.fromARGB(239, 39, 53, 176),
                                size: 30,
                              ),
                              onClick: _resetTimerCountDown,
                            ),
                            CustomBtn(
                              borderColor: Colors.transparent,
                              color: const Color.fromARGB(239, 39, 53, 176),
                              icon: mainBtnIcon,
                              onClick: _mainBtnClicked,
                            ),
                            CustomBtn(
                              borderColor:
                                  const Color.fromARGB(239, 39, 53, 176),
                              color: Colors.transparent,
                              icon: const Icon(
                                Icons.stop,
                                color: Color.fromARGB(239, 39, 53, 176),
                                size: 30,
                              ),
                              onClick: _resetRemaingTimerCountDown,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _secsToFormatedString(int secs) {
    int roundedMinutes = secs ~/ 60;
    int remaingSecs = secs - (roundedMinutes * 60);
    String remainSecsFormated;
    if (remaingSecs < 10) {
      remainSecsFormated = '0$remaingSecs';
    } else {
      remainSecsFormated = remaingSecs.toString();
    }
    return '$roundedMinutes:$remainSecsFormated';
  }

  _getPomodoroPercentage() {
    int totalTime;
    switch (pomodoroStatus) {
      case PomodoroStatus.runningPomodoro:
        totalTime = pomodoroTotalTime;
        mainCurrentStatus = _enterStatus;

        break;
      case PomodoroStatus.pausedPomodoro:
        mainCurrentStatus = _enterStatus;

        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.runningShortBreak:
        totalTime = shortBreakTime;
        break;
      case PomodoroStatus.pausedShortBreak:
        totalTime = shortBreakTime;
        break;
      case PomodoroStatus.runningLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroStatus.pausedLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroStatus.setFinished:
        totalTime = pomodoroTotalTime;
        break;
    }
    double percentage = (totalTime - remaingTime) / totalTime;
    return percentage;
  }

  void _mainBtnClicked() {
    switch (pomodoroStatus) {
      case PomodoroStatus.pausedPomodoro:
        _startTimerCountDown();
        break;
      case PomodoroStatus.runningPomodoro:
        _pauseTimerCountDown();
        break;
      case PomodoroStatus.runningShortBreak:
        _pauseShortBreakTimerCountDown();
        break;
      case PomodoroStatus.pausedShortBreak:
        _startShortBreakTimerCountDown();
        break;
      case PomodoroStatus.pausedLongBreak:
        _startLongBreakTimerCountDown();
        break;
      case PomodoroStatus.runningLongBreak:
        _pauseLongBreakTimerCountDown();
        break;
      case PomodoroStatus.setFinished:
        setNumber++;
        _startTimerCountDown();
        break;
    }
  }

  _startTimerCountDown() {
    pomodoroStatus = PomodoroStatus.runningPomodoro;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => {
        if (remaingTime > 0)
          {
            setState(() {
              remaingTime--;
              mainBtnIcon = _btnPauseIcon;
            }),
          }
        else
          {
            _notificationSound(),
            pomodoNumber++,
            _cancelTimer(),
            if (pomodoNumber % pomodoroPerSet == 0)
              {
                pomodoroStatus = PomodoroStatus.pausedLongBreak,
                setState(() {
                  remaingTime = longBreakTime;
                  mainBtnIcon = _startBtnIcon;
                  mainCurrentStatus = _longBreakStatus;
                }),
              }
            else
              {
                pomodoroStatus = PomodoroStatus.pausedShortBreak,
                setState(() {
                  remaingTime = shortBreakTime;
                  mainBtnIcon = _startBtnIcon;

                  mainCurrentStatus = _shortBreakStatus;
                })
              }
            // playSound(),
          }
      },
    );
  }

  _pauseTimerCountDown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    _cancelTimer();
    setState(() {
      mainBtnIcon = _startBtnIcon;
    });
  }

  _resetTimerCountDown() {
    pomodoNumber = 0;
    setNumber = 0;
    mainBtnIcon = _startBtnIcon;
    _cancelTimer();
    _stopTimerCountDown();
  }

  _resetRemaingTimerCountDown() {
    mainBtnIcon = _startBtnIcon;
    remaingTime = pomodoroTotalTime;
    _cancelTimer();
    _stopTimerCountDown();
  }

  _stopTimerCountDown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    setState(() {
      mainBtnText = _btnStartPomo;
      remaingTime = pomodoroTotalTime;
      mainCurrentStatus = _enterStatus;
    });
  }

  _pauseShortBreakTimerCountDown() {
    pomodoroStatus = PomodoroStatus.pausedShortBreak;
    _pauseBreakTimerCountDown();
  }

  _pauseLongBreakTimerCountDown() {
    pomodoroStatus = PomodoroStatus.pausedLongBreak;
    _pauseBreakTimerCountDown();
  }

  _pauseBreakTimerCountDown() {
    _cancelTimer();
    setState(() {
      mainBtnIcon = _startBtnIcon;
    });
  }

  _cancelTimer() {
    // ignore: unnecessary_null_comparison
    if (_timer != null) {
      _timer.cancel();
    }
  }

  _startShortBreakTimerCountDown() {
    pomodoroStatus = PomodoroStatus.runningShortBreak;
    _cancelTimer();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => {
        if (remaingTime > 0)
          {
            setState(
              () {
                remaingTime--;
              },
            ),
          }
        else
          {
            _notificationSound(),
            remaingTime = pomodoroTotalTime,
            _cancelTimer(),
            pomodoroStatus = PomodoroStatus.pausedPomodoro,
            setState(
              () {
                mainBtnText = _btnStartPomo;
                mainBtnIcon = _startBtnIcon;
              },
            ),
          }
      },
    );
  }

  _startLongBreakTimerCountDown() {
    pomodoroStatus = PomodoroStatus.runningLongBreak;
    _cancelTimer();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => {
        if (remaingTime > 0)
          {
            setState(
              () {
                remaingTime--;
              },
            ),
          }
        else
          {
            _notificationSound(),
            remaingTime = pomodoroTotalTime,
            _cancelTimer(),
            pomodoroStatus = PomodoroStatus.setFinished,
            setState(
              () {
                // mainBtnText = _btnStartNewSet;
                mainBtnIcon = _startBtnIcon;

                mainCurrentStatus = 'Props';
              },
            ),
          }
      },
    );
  }

  _notificationSound() {
    // print('Sound');
  }
}
