import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:time_managment_app/src/presentation/widgets/button/custom_btn.dart';
import 'package:time_managment_app/src/presentation/widgets/progress_status/progress_status.dart';
import 'package:time_managment_app/src/domain/models/timer_status_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            const Text('Pomodoro Number'),
            const Text('Pomodoro Number'),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 15.0,
                    percent: 0.3,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: const Text('25:00'),
                    progressColor: Colors.orange,
                  ),
                  const SizedBox(height: 40),
                  const ProgressStatus(done: 2, total: 4),
                  const SizedBox(height: 40),
                  CustomBtn(
                    onClick: () {},
                    btnTxt: 'Ok',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
