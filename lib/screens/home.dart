import 'package:appfood/screens/main_rider.dart';
import 'package:appfood/screens/main_shop.dart';
import 'package:appfood/screens/main_user.dart';
import 'package:appfood/screens/signin.dart';
import 'package:appfood/screens/signup.dart';
import 'package:appfood/utility/my_style.dart';
import 'package:appfood/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreference();
  }

  Future<Null> checkPreference() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String typeuser = preferences.getString('choosetype');
      if (typeuser != null && typeuser.isNotEmpty) {
        if (typeuser == 'User') {
          routeToService(MainUser());
        } else if (typeuser == 'shop') {
          routeToService(MainShop());
        } else if (typeuser == 'rider') {
          routeToService(MainRider());
        } else {
          normalDialog(context, 'Error User type');
        }
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            signInMenu(),
            signupMenu(),
          ],
        ),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign In'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signupMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign Up'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Signup());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('guest.jpg'),
      currentAccountPicture: MyStyle().showlogo(),
      accountName: Text(
        'Guest',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 20.0),
      ),
      accountEmail: Text(
        'Please Login',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 20.0),
      ),
    );
  }
}
