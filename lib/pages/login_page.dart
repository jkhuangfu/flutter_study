import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/models/demo.dart';
import 'package:flutter_study/utils/utils.dart';
import 'package:flutter_study/widgets/widget.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usercontroller = TextEditingController();

  TextEditingController _pwdcontroller = TextEditingController();
  // 注册手势
  TapGestureRecognizer _forgetProtocolRecognizer;

  var parmas = {"userName": '', "passWord": ''};

  /// 清除输入框内容
  void clearInputValue(int type) {
    if (type == 1) {
      _usercontroller.clear();
    } else {
      _pwdcontroller.clear();
    }
  }

  @override
  void initState() {
    _forgetProtocolRecognizer = TapGestureRecognizer();
    super.initState();
  }

  @override
  void dispose() {
    _forgetProtocolRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 130),
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: inputEdit(
                      width: 300,
                      mL: 3,
                      hintText: '请输入用户名',
                      controller: _usercontroller,
                      onChanged: (data) {
                        setState(() {
                          parmas["userName"] = data;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: inputEdit(
                      width: 300,
                      hintText: '请输入密码',
                      isPassword: true,
                      onChanged: (data) {
                        setState(() {
                          parmas["passWord"] = data;
                        });
                      },
                      controller: _pwdcontroller,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(40),
                          onPressed: () async {
                            // Navigator.pushNamed(context, 'home');
                            Map<String, dynamic> data = await getResponse(
                                'get',
                                'http://127.0.0.1:3330/common/flutter',
                                {'type': 1});
                            print(data);

                            var demo = new Demo.fromJson(data);
                            print(demo.result.data);
                            // return null;
                            // print(parmas);
                            // if (parmas['userName'] == '') {
                            //   return Fluttertoast.showToast(
                            //       msg: '请输入用户名',
                            //       backgroundColor: Colors.grey,
                            //       gravity: ToastGravity.TOP,
                            //       textColor: Colors.white,
                            //       fontSize: 16);
                            // }

                            // if (parmas['passWord'] == '') {
                            //   return Fluttertoast.showToast(
                            //       msg: '请输入密码',
                            //       backgroundColor: Colors.grey,
                            //       gravity: ToastGravity.TOP,
                            //       textColor: Colors.white,
                            //       fontSize: 16);
                            // }
                          },
                          child: Text(
                            '登陆',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 90,
                  child: Align(
                    child: RichText(
                      text: TextSpan(
                        text: '忘记密码',
                        recognizer: _forgetProtocolRecognizer
                          ..onTap = () => {print('忘记密码')},
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            color: Colors.grey),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
