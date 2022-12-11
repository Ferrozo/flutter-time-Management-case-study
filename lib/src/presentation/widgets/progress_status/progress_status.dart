import 'package:flutter/material.dart';

class ProgressStatus extends StatelessWidget {
  const ProgressStatus({Key? key, required this.total, required this.done})
      : super(key: key);

  final int total;
  final int done;

  @override
  Widget build(BuildContext context) {
    double iconSize = 20.0;

    final doneIcon = Icon(
      Icons.beenhere,
      color: Colors.orange,
      size: iconSize,
    );
    final notDoneIcon = Icon(
      Icons.beenhere,
      color: Colors.grey,
      size: iconSize,
    );

    final List<Icon> icons = [];
    for (int i = 0; i < total; i++) {
      if (i < done) {
        icons.add(doneIcon);
      } else {
        icons.add(notDoneIcon);
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: icons,
    );
  }
}
