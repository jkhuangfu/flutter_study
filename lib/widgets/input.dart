import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {String hintText输入提示,double width宽,double height高度,bool read是否只读默认false,int mL =10 最大输入长度 ,bool isPassword = false 是否是密码输入,Function onChanged ,TextEditingController controller}
Widget inputEdit(
    {String hintText = '',
    double width = 250,
    double height = 60,
    bool read = false,
    int mL = 10,
    bool isPassword = false,
    Function onChanged,
    TextEditingController controller}) {
  return Container(
    child: Container(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: isPassword,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(mL)
        ],
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          fillColor: Color(0x30cccccc),
          contentPadding: EdgeInsets.all(14),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00FF0000)),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00000000)),
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
      ),
    ),
  );
}
