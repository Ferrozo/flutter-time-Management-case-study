import 'package:flutter/material.dart';

class ProgressStatus extends StatelessWidget {
  const ProgressStatus({Key? key, required this.total, required this.done})
      : super(key: key);

  final int total;
  final int done;

  @override
  Widget build(BuildContext context) {
    double containerSize = 20.0;

    final doneContainer = Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: Colors.orange,
        border: Border.all(width: 2.5, color: Colors.orange),
        borderRadius: BorderRadius.circular(50),
      ),
    );

    final unDoneContainer = Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 2.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(50),
      ),
    );

    final List<Container> containers = [];
    for (int i = 0; i < total; i++) {
      if (i < done) {
        containers.add(doneContainer);
        // icons.add(doneIcon);
      } else {
        // icons.add(notDoneIcon);
        containers.add(unDoneContainer);
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: containers,
      ),
    );
  }
}
