import 'package:appfood/utility/my_style.dart';
import 'package:appfood/utility/signout_process.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainRider extends StatefulWidget {
  @override
  _MainRiderState createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  String nameUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? 'Main Rider' : '$nameUser Login'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),
      drawer: showdrawer(),
    );
  }

  Drawer showdrawer() => Drawer(
        child: ListView(
          children: <Widget>[showHead()],
        ),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('rider.jpg'),
      currentAccountPicture: MyStyle().showlogo(),
      accountName: Text('$nameUser Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold, fontSize: 20.0,),),
      accountEmail: Text('Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold, fontSize: 20.0,),),
    );
  }
}
