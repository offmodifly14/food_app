import 'dart:convert';

import 'package:appfood/model/user_model.dart';
import 'package:appfood/screens/main_rider.dart';
import 'package:appfood/screens/main_shop.dart';
import 'package:appfood/screens/main_user.dart';
import 'package:appfood/utility/my_style.dart';
import 'package:appfood/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //ประกาศตัวแปร
  String user,password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, Colors.orange.shade200],
          center: Alignment(0, -0.3),
          radius: 1.0,
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showlogo(),
                MyStyle().mySizebox(),
                MyStyle().showTitle('Application Food'),
                MyStyle().mySizebox(),
                userForm(),
                MyStyle().mySizebox(),
                passwordForm(),
                MyStyle().mySizebox(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Container(
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        onPressed: () {
          if(user == null || user.isEmpty || password ==null || password.isEmpty){
            normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วนด้วยครับ');
          }else{
            checkuser();
          }

        },
        child: Text(
          'Loign',
          style: TextStyle(color: Colors.white),
        ),
      ));

  Future<Null> checkuser() async{
    String url='http://192.168.43.92/food_app/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print('$result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if(password == userModel.password){
          String choosetype = userModel.choosetype;
          if(choosetype =='User'){
            routeToService(MainUser(), userModel);
          }else if(choosetype =='shop'){
                routeToService(MainShop(), userModel);
          }else if(choosetype=='rider'){
              routeToService(MainRider(), userModel);
          }else{
             normalDialog(context, 'error');
          }
        }else{
          normalDialog(context, 'ท่านใส่ password ผิด');
        }
      }
    } catch (e) {
    }
  }

  Future<Null> routeToService(Widget myWidget, UserModel userModel)async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('choosetype', userModel.choosetype);
    preferences.setString('name', userModel.name);

    MaterialPageRoute route = MaterialPageRoute(builder: (context)=> myWidget,);
    Navigator.pushAndRemoveUntil(context, route, (route)  => false);
    
  }

  Widget userForm() => Container(
        child: TextField(
          onChanged:(value) => user=value.trim() ,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box, color: MyStyle().darkColor),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'User',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            ),
          ),
        ),
        width: 250.0,
      );

  Widget passwordForm() => Container(
        child: TextField(
          onChanged: (value) => password=value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: MyStyle().darkColor),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            ),
          ),
        ),
        width: 250.0,
      );
}
