import 'package:flutter/material.dart';
import 'package:time_managment_app/src/domain/models/timer_status_model.dart';

const pomodoroTotalTime = 25 * 60;
const shortBreak = 5 * 60;
const longBreak = 15 * 60;
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
