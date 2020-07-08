import 'package:appfood/screens/add_info_shop.dart';
import 'package:appfood/utility/my_style.dart';
import 'package:flutter/material.dart';

class InformationShop extends StatefulWidget {
  @override
  _InformationShopState createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyStyle()
            .titleCenter(context, 'ยังไม่มีข้อมูลกรุณา เพิ่มข้อมูลด้วยครับ'),
        addEditButton()
      ],
    );
  }

  Row addEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(16.0),
                child: FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () => routeToAddInfo(),
            )),
          ],
        ),
      ],
    );
  }

  void routeToAddInfo(){
    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (context) => AddInfoShop(),);
    Navigator.push(context, materialPageRoute);
  }
}
