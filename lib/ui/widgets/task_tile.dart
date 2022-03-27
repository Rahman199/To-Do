import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/ui/theme.dart';

import '../../models/task.dart';
import '../size_config.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
    this.task, {
    Key? key,
  }) : super(key: key);

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: getProportionateScreenWidth(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task?.color ?? 0),
        ),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task?.title ?? '',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${task!.startTime} - ${task!.endTime}',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      task?.note ?? '',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.1),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isCompleted == 1 ? 'COMPLETED' : 'TODO',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
