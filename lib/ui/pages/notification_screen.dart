import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);
  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          _payload.toString().split('|')[1],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 158, 4, 30)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.only(top: 12.0),
              height: 40,
              width: 300,
              child: Text(
                'Hi ! ',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(top: 12.0),
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 239, 241),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0), spreadRadius: 3)
                  ]),
              child: Text(
                'you have a new reminder',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode
                        ? Color.fromARGB(230, 58, 58, 58)
                        : const Color.fromARGB(218, 180, 6, 87)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Get.isDarkMode
                        ? Color.fromARGB(210, 46, 45, 45)
                        : const Color.fromARGB(218, 180, 6, 87)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.text_format, size: 30),
                          SizedBox(width: 20),
                          Text(
                            'Titel',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _payload.toString().split('|')[0],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.description_outlined, size: 30),
                          const SizedBox(width: 20),
                          Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 26,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.white),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Hier sollte wieder verbessert sein
                      Text(
                        _payload.toString().split('|')[1],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 30),
                          const SizedBox(width: 20),
                          Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 32,
                                wordSpacing: 10,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.white),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _payload.toString().split('|')[2],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
