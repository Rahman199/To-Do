import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';
import '../../models/task.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskcontroller = Get.put(TaskController());
  final TextEditingController _titelControlller = TextEditingController();
  final TextEditingController _noteControlller = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('h:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('h:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputField(
                  title: 'Titel',
                  hint: 'Enter your titel',
                  controller: _titelControlller),
              const SizedBox(
                height: 8,
              ),
              InputField(
                  title: 'Note',
                  hint: 'Enter your note',
                  controller: _noteControlller),
              const SizedBox(
                height: 8,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(Icons.calendar_today_rounded),
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime.toString(),
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(Icons.access_time_rounded),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime.toString(),
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                        icon: const Icon(Icons.access_time_rounded),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                title: 'Remind ',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  items: remindList
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem(
                          value: value.toString(),
                          child: Text(
                            '$value',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  style: subTitelStyle,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                ),
              ),
              InputField(
                title: 'Repeat ',
                hint: _selectedRepeat,
                widget: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blueGrey,
                  items: repeatList
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  style: subTitelStyle,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                    label: 'Creat Task',
                    onTap: () {
                      _validdateDate();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Add Task ',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: context.theme.backgroundColor,
      actions: const [
        Icon(
          Icons.task_alt_rounded,
          color: Colors.black,
        ),
        SizedBox(width: 60),
        CircleAvatar(
          backgroundImage: AssetImage('images/person.png'),
          radius: 18,
        ),
        SizedBox(
          width: 20,
        )
      ],
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: primaryClr,
        ),
      ),
    );
  }

  _validdateDate() {
    if (_titelControlller.text.isNotEmpty && _noteControlller.text.isNotEmpty) {
      _addTaskstoDb();
      print('new Task is added !!');
      Get.back();
    } else if (_titelControlller.text.isEmpty ||
        _noteControlller.text.isEmpty) {
      Get.snackbar('required', 'All fields are required ! ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          overlayColor: Colors.red,
          backgroundGradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: const Color.fromARGB(255, 251, 255, 0),
          ));
    } else {
      print('  _validdateDate() wrong !!!!');
    }
  }

  _addTaskstoDb() async {
    try {
      int value = await _taskcontroller.addTask(
        task: Task(
          title: _titelControlller.text,
          note: _noteControlller.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime.toString(),
          endTime: _endTime.toString(),
          color: _selectedColor,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
        ),
      );
      print('my id is +' + '$value');
    } catch (e) {
      print(' _addTaskstoDB  Error !!');
    }
  }

  Padding _colorPalette() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: titelStyle,
          ),
          Wrap(
            children: List<Widget>.generate(
              3,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: CircleAvatar(
                    child: _selectedColor == index
                        ? const Icon(Icons.done, size: 16, color: Colors.white)
                        : null,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr,
                    radius: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2230),
    );
    if (pickedDate != null)
      setState(() => _selectedDate = pickedDate);
    else
      print(' _pickedDate null or something is worng ');
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? Container(),
          );
        },
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(':')[0]),
            minute: int.parse(_startTime.split(':')[1].split(' ')[0])));
  }

/*
  getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = await pickedTime.format(context);

    if (pickedTime == null) {
      print('time canceld or something is wrong');
    } else {
      if (isStartTime == true)
        setState(() => _startTime = _formatedTime);
      else if (isStartTime == false) setState(() => _endTime = _formatedTime);
    }
  }
*/
  _getTimeFromUser({required bool isStartTime}) async {
    print(DateFormat.jm().format(DateFormat('h:mm:ss').parse('12:15:00')));
    TimeOfDay? _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15)),
            ),
    );
    if (_pickedTime == null) {
      print('time canceld or something is wrong');
      return const AddTaskPage();
    }
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(_pickedTime,
        alwaysUse24HourFormat: false);
    //String _formattedTime = _pickedTime!.format(context);
    String _formattedTime = _pickedTime.format(context);

    if (isStartTime == true) {
      setState(() => _startTime = formattedTime);
    } else {
      if (isStartTime == false)
        setState(() => _endTime = formattedTime);
      else
        print('time canceld or something is wrong');
    }
  }
}
