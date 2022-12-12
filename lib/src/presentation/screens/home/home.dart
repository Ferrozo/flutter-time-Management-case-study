import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:time_managment_app/src/core/utils/constants.dart';
import 'package:time_managment_app/src/domain/models/timer_status_model.dart';
import 'package:time_managment_app/src/presentation/widgets/button/custom_btn.dart';
import 'package:time_managment_app/src/presentation/widgets/progress_status/progress_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const String _btnStartPomo = 'Start';
const String _btnPausePomo = 'pause pomo';
const String _btnResetPomo = 'reset pomo';
const String _btnStartShortBreak = 'Start shork';
const String _btnStartLongBreak = 'Start';
const String _btnResumePomo = 'resume';
const String _btnResumeBreak = 'Reusme';
const String _btnStartNewSet = 'Start new set';

class _HomePageState extends State<HomePage> {
  int remaingTime = pomodoroTotalTime;
  String mainBtnText = _btnStartPomo;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text('Pomodoro Number $pomodoNumber'),
            Text('Set Number $setNumber'),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 8.0,
                    percent: _getPomodoroPercentage(),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(_secsToFormatedString(remaingTime)),
                    progressColor: statusColor[pomodoroStatus],
                  ),
                  const SizedBox(height: 40),
                  ProgressStatus(
                      done: pomodoNumber - (setNumber * pomodoroPerSet),
                      total: pomodoroPerSet),
                  const SizedBox(height: 40),
                  Text(statusDescription[pomodoroStatus].toString()),
                  // CustomBtn(
                  //   onClick: () {},
                  //   btnTxt: mainBtnText,
                  // ),
                  ElevatedButton(
                      onPressed: _mainBtnClicked, child: Text(mainBtnText)),
                  ElevatedButton(
                      onPressed: _resetTimerCountDown,
                      child: const Text('reset')),
                ],
              ),
            ),
          ],
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
    return '$roundedMinutes : $remainSecsFormated';
  }

  _getPomodoroPercentage() {
    int totalTime;
    switch (pomodoroStatus) {
      case PomodoroStatus.runningPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.pausedPomodoro:
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

  _mainBtnClicked() {
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
        break;
      case PomodoroStatus.runningLongBreak:
        _pauseLongBreakTimerCountDown();
        break;
      case PomodoroStatus.setFinished:
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
              mainBtnText = _btnPausePomo;
            }),
          }
        else
          {
            pomodoNumber++,
            _cancelTimer(),
            if (pomodoNumber % pomodoroPerSet == 0)
              {
                pomodoroStatus = PomodoroStatus.pausedLongBreak,
                setState(() {
                  remaingTime = longBreakTime;
                  mainBtnText = _btnStartLongBreak;
                }),
              }
            else
              {
                pomodoroStatus = PomodoroStatus.pausedShortBreak,
                setState(() {
                  remaingTime = shortBreakTime;
                  mainBtnText = _btnStartShortBreak;
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
      mainBtnText = _btnResumePomo;
    });
  }

  _resetTimerCountDown() {
    pomodoNumber = 0;
    setNumber = 0;
    _cancelTimer();
    _stopTimerCountDown();
  }

  _stopTimerCountDown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    setState(() {
      mainBtnText = _btnStartPomo;
      remaingTime = pomodoroTotalTime;
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
      mainBtnText = _btnResumeBreak;
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
  }
}
