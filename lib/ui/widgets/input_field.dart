import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/size_config.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titelStyle),
          Container(
            padding: EdgeInsets.only(left: 8),
            width: SizeConfig.screenWidth,
            height: 52,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 1)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: controller,
                    autofocus: false,
                    readOnly: widget != null ? true : false,
                    style: subTitelStyle,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitelStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0),
                      ),
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
