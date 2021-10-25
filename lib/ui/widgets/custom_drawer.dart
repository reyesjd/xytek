import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/home/main.dart';
import 'package:xytek/ui/pages/profile/shopper_page.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: TextButton(
                onPressed: () {
                  Get.to(() => Shopper());
                },
                child: Text(
                  "John Doe",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              )),
          ListTile(
            title: Text("Inicio"),
            onTap: () {
              Get.to(() => Main());
            },
          ),
          ListTile(
            title: Text("Categorías"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Productos"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Historial"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
