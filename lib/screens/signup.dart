import 'package:appfood/utility/my_style.dart';
import 'package:appfood/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, Colors.orange.shade100],
          center: Alignment(0, -0.3),
          radius: 1.0,
        )),
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            mylogo(),
            MyStyle().mySizebox(),
            showAppname(),
            MyStyle().mySizebox(),
            nameform(),
            MyStyle().mySizebox(),
            userform(),
            MyStyle().mySizebox(),
            passwordform(),
            MyStyle().mySizebox(),
            MyStyle().showTitleH2('Type Member :'),
            userRadio(),
            shopRadio(),
            riderRadio(),
            MyStyle().mySizebox(),
            registerButton(),
          ],
        ),
      ),
    );
  }

  Widget userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                    value: 'User',
                    groupValue: chooseType,
                    onChanged: (value) {
                      setState(() {
                        chooseType = value;
                      });
                    }),
                Text('ผู้สั่งอาหาร',
                    style: TextStyle(color: MyStyle().darkColor)),
              ],
            ),
          ),
        ],
      );

  Widget shopRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                    value: 'shop',
                    groupValue: chooseType,
                    onChanged: (value) {
                      setState(() {
                        chooseType = value;
                      });
                    }),
                Text('เจ้าของร้านอาหาร',
                    style: TextStyle(color: MyStyle().darkColor)),
              ],
            ),
          ),
        ],
      );

  Widget riderRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                    value: 'rider',
                    groupValue: chooseType,
                    onChanged: (value) {
                      setState(() {
                        chooseType = value;
                      });
                    }),
                Text('ผู้ส่งอาหาร',
                    style: TextStyle(color: MyStyle().darkColor)),
              ],
            ),
          ),
        ],
      );

  Widget nameform() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.face, color: MyStyle().darkColor),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Name:',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().darkColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().primaryColor),
                ),
              ),
            ),
            width: 250.0,
          ),
        ],
      );

  Widget userform() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_box, color: MyStyle().darkColor),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Username:',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().darkColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().primaryColor),
                ),
              ),
            ),
            width: 250.0,
          ),
        ],
      );

  Widget passwordform() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: TextField(
              onChanged: (value) => password = value.trim(),
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: MyStyle().darkColor),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Password:',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().darkColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyStyle().primaryColor),
                ),
              ),
            ),
            width: 250.0,
          ),
        ],
      );

  Row showAppname() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyStyle().showTitle('Application Food Register'),
      ],
    );
  }

  Widget mylogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyStyle().showlogo(),
        ],
      );

  Future<Null>registerThread() async{  // รับข้อมูลจากฟอร์ม เพื่อโยนขึ้น api
    String url = 'http://192.168.43.92/food_app/adduser.php?isAdd=true&Name=$name&User=$user&Password=$password&choosetype=$chooseType';

    try {
      Response response  = await Dio().get(url);
      print('res = $response');
      if(response.toString()=="true"){
        Navigator.pop(context);
      }else{
        normalDialog(context, 'ไม่สามารถทำการสมัครข้อมูลได้');
      }
    } catch (e) {
    } 
  }

  Future<Null> checkUser()async{
    String url='http://192.168.43.92/food_app/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      print(response);
      if(response.toString()=='null'){
          registerThread();

      }else{
        normalDialog(context, 'User: $user มีการใช้แล้วกรุณาเปลี่ยน user ใหม่');
      }
    } catch (e) {
    }
  }

  Widget registerButton() => Container(
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        onPressed: () {
         if(name == null || name.isEmpty || user == null || user.isEmpty || password == null || password.isEmpty ){
           
           normalDialog(context, 'กรุณากรอกข้อมูลในช่องที่ยังไม่ได้กรอกด้วย');
         }else if(chooseType == null ){
              normalDialog(context, 'กรุณาเลือกชนิดผู้ใช้บริการด้วย');
         }else{
            checkUser();
         }
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ));

}
