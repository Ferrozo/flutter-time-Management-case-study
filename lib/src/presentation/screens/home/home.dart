import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:time_managment_app/src/core/utils/constants.dart';
import 'package:time_managment_app/src/domain/models/timer_status_model.dart';
// import 'package:time_managment_app/src/presentation/widgets/button/custom_btn.dart';
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
                    lineWidth: 15.0,
                    percent: 0.9,
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
                  ElevatedButton(
                      onPressed: _mainBtnClicked, child: const Text('Ok')),
                  // CustomBtn(
                  //   onClick: _mainBtnClicked,
                  //   btnTxt: 'Ok',
                  // ),
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

  _mainBtnClicked() {
    switch (pomodoroStatus) {
      case PomodoroStatus.runningPomodoro:
        break;
      case PomodoroStatus.pausedPomodoro:
        _startTimerCountDown();
        break;
      case PomodoroStatus.runningShortBreak:
        break;
      case PomodoroStatus.pausedShortBreak:
        break;
      case PomodoroStatus.pausedLongBreak:
        break;
      case PomodoroStatus.runningLongBreak:
        break;
      case PomodoroStatus.setFinished:
        break;
    }
  }

  _startTimerCountDown() {
    pomodoroStatus = PomodoroStatus.runningPomodoro;
    _cancelTimer();
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

  _cancelTimer() {
    _timer.cancel();
  }
}
