import 'package:flutter/material.dart';
import 'package:time_managment_app/src/domain/models/timer_status_model.dart';

const pomodoroTotalTime = 25 * 60;
const shortBreakTime = 5 * 60;
const longBreakTime = 15 * 60;
const pomodoroPerSet = 4;

const Map<PomodoroStatus, Icon> iconDescription = {
  PomodoroStatus.runningPomodoro: Icon(
    Icons.watch_later_outlined,
    color: Colors.white70,
    size: 30,
  ),
  PomodoroStatus.pausedPomodoro: Icon(
    Icons.pause_sharp,
    color: Colors.white70,
    size: 30,
  ),
  PomodoroStatus.runningShortBreak: Icon(
    Icons.coffee,
    color: Colors.white70,
    size: 30,
  ),
  PomodoroStatus.pausedShortBreak: Icon(
    Icons.pause_sharp,
    color: Colors.white70,
    size: 30,
  ),
  PomodoroStatus.runningLongBreak: Icon(
    Icons.directions_walk_outlined,
    color: Colors.white70,
    size: 30,
  ),
  PomodoroStatus.pausedLongBreak: Icon(
    Icons.pause_sharp,
    color: Colors.white70,
    size: 30,
  ),
  PomodoroStatus.setFinished: Icon(
    Icons.done_all,
    color: Colors.white70,
    size: 30,
  )
};

const Map<PomodoroStatus, Color> statusColor = {
  PomodoroStatus.runningPomodoro: Color.fromARGB(239, 39, 53, 176),
  PomodoroStatus.pausedPomodoro: Color.fromARGB(255, 255, 196, 0),
  PomodoroStatus.runningShortBreak: Color.fromARGB(255, 222, 73, 63),
  PomodoroStatus.pausedShortBreak: Colors.orange,
  PomodoroStatus.runningLongBreak: Color.fromARGB(255, 222, 73, 63),
  PomodoroStatus.pausedLongBreak: Colors.orange,
  PomodoroStatus.setFinished: Color.fromARGB(255, 255, 196, 0),
};
