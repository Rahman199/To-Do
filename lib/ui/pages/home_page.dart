import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/pages/add_task_page.dart';
import 'package:todo_app/ui/widgets/button.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/ui/widgets/task_tile.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../size_config.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    var notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    _taskController.getTasks();
  }

  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            const SizedBox(height: 8),
            _showTasks(),
          ],
        ));
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 40,
      centerTitle: true,
      backgroundColor: context.theme.backgroundColor,
      actions: [
        IconButton(
            icon: Icon(
              Icons.cleaning_services_rounded,
              size: 24,
              color: Get.isDarkMode ? Colors.white : darkGreyClr,
            ),
            onPressed: () {
              _taskController.deleteAllTasks();
              NotifyHelper().cancelAllNotification();
            }),
        const CircleAvatar(
          backgroundImage: AssetImage('images/person.png'),
          radius: 18,
        ),
        const SizedBox(
          width: 20,
        )
      ],
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
          // NotifyHelper()
          //     .displayNotification(titel: ' Theme Changed ', body: '');
        },
        icon: Icon(
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: 24,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMd().format(DateTime.now()),
                  style: subHheadingStyle),
              Text('Today', style: headingStyle),
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTap: () async {
              await Get.to(() => const AddTaskPage());

              _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 202, 27, 4),
          ),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 165, 22, 4),
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 202, 27, 4),
          ),
        ),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskListe.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemCount: _taskController.taskListe.length,
              itemBuilder: (BuildContext context, int index) {
                var task = _taskController.taskListe[index];
                print(task.toJson());
                if (task.date == DateFormat.yMd().format(_selectedDate) ||
                    task.repeat == 'Daily' ||
                    (task.repeat == 'Weekly' &&
                        _selectedDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date!))
                                    .inDays %
                                7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date!).day ==
                            _selectedDate.day)) {
                  var hour = task.startTime.toString().split(':')[0];
                  var minutes = task.startTime.toString().split(':')[1];
                  debugPrint('my time is ' + hour);

                  debugPrint('my minute is ' + minutes);

                  var date = DateFormat.jm().parse(task.startTime!);

                  var myTime = DateFormat('HH:mm').format(date);
                  print(myTime);
                  NotifyHelper().scheduledNotification(
                      int.parse(myTime.toString().split(':')[0]),
                      int.parse(myTime.toString().split(':')[1]),
                      task);

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 2000),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(
                            task,
                          ),
                        ),
                      ),
                    ),
                  );
                } else
                  print('no Show Task');
                return Center(child: Container(color: Colors.red));
              },
            ),
          );
        }
      }),
    );
    // return Expanded(
    //   child: GestureDetector(
    //     onTap: () {
    //       _showBottomSheet(
    //         context,
    //         Task(
    //           title: 'Titel 1',
    //           note: 'Note Something',
    //           isCompleted: 0,
    //           startTime: '8:20',
    //           endTime: '9:20',
    //           color: 1,
    //         ),
    //       );
    //     },
    //     child: TaskTile(
    //       task: Task(
    //         title: 'Titel 1',
    //         note: 'Note Something',
    //         isCompleted: 0,
    //         startTime: '8:20',
    //         endTime: '9:20',
    //         color: 1,
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<void> _onRefresh() async {
    _taskController.getTasks();
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 220,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset('images/task.svg',
                      width: 80,
                      height: 90,
                      color: primaryClr.withOpacity(0.5)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(' You do not have any task yet '),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 120,
                        )
                      : const SizedBox(
                          height: 180,
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          //alignment: AlignmentDirectional.bottomCenter,
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.30
                  : SizeConfig.screenHeight * 0.39),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomShett(
                      label: 'Task Completed',
                      onTap: () {
                        print("Task Completed");
                        _taskController.markTaskCompleted(task.id!);
                        NotifyHelper().cancelNotification(task);
                        Get.back();
                      },
                      clr: primaryClr),
              _buildBottomShett(
                  label: 'Delete Task ',
                  onTap: () {
                    NotifyHelper().cancelNotification(task);
                    _taskController.deleteTask(task);
                    _taskController.getTasks();
                    Get.back();
                  },
                  clr: Colors.red),
              Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
              _buildBottomShett(
                  label: 'Cancel',
                  onTap: () {
                    Get.back();
                  },
                  clr: primaryClr),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomShett({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true ? Colors.red : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.red : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titelStyle : titelStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
