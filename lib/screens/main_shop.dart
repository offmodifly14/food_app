import 'package:appfood/utility/my_style.dart';
import 'package:appfood/utility/signout_process.dart';
import 'package:appfood/widget/information_shop.dart';
import 'package:appfood/widget/list_foodmenu_shop.dart';
import 'package:appfood/widget/order_list_shop.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  String nameUser;
  Widget currentWidget = OrderListShop();
  @override
  void initState() {
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
        title: Text(nameUser == null ? 'Main shop' : '$nameUser Login'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),
      drawer: showdrawer(),
      body: currentWidget,
    );
  }

  Drawer showdrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            foodMenu(),
            informationMenu(),
            signoutMenu(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการอาหารที่ลูกค้าสั้่ง'),
        subtitle: Text('รายการอาหารที่ยังไม่ได้ส่ง'),
       onTap: (){
         setState(() {
           currentWidget=OrderListShop();
         });
         Navigator.pop(context);
       },
        
      );

  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('รายการอาหารของร้าน'),
        subtitle: Text('รายการอาหารของร้าน'),
        onTap: () {
          setState(() {
            currentWidget=ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile informationMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละเอียดของร้าน'),
        subtitle: Text('รายละเอียดของร้าน พร้อม Edit'),
        onTap: () {
          setState(() {
            currentWidget=InformationShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile signoutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Signout'),
        subtitle: Text('ออกจากระบบ'),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('shop.jpg'),
      currentAccountPicture: MyStyle().showlogo(),
      accountName: Text(
        '$nameUser Login',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
