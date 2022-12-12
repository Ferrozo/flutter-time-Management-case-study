import 'package:flutter/material.dart';
import 'package:time_managment_app/src/domain/models/timer_status_model.dart';

const pomodoroTotalTime = 25 * 60;
const shortBreakTime = 5 * 60;
const longBreakTime = 15 * 60;
const pomodoroPerSet = 4;

const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.runningPomodoro: 'Pomodoro is running, timer',
  PomodoroStatus.pausedPomodoro: 'paused Pomodoro',
  PomodoroStatus.runningShortBreak: 'Short break is running',
  PomodoroStatus.pausedShortBreak: 'Paused short break',
  PomodoroStatus.runningLongBreak: 'Long break is running',
  PomodoroStatus.pausedLongBreak: 'Paused long break',
  PomodoroStatus.setFinished: 'Congratulations',
};

const Map<PomodoroStatus, MaterialColor> statusColor = {
  PomodoroStatus.runningPomodoro: Colors.green,
  PomodoroStatus.pausedPomodoro: Colors.orange,
  PomodoroStatus.runningShortBreak: Colors.red,
  PomodoroStatus.pausedShortBreak: Colors.orange,
  PomodoroStatus.runningLongBreak: Colors.red,
  PomodoroStatus.pausedLongBreak: Colors.orange,
  PomodoroStatus.setFinished: Colors.orange,
};
