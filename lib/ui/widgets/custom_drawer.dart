import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Text(
                "John Doe",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              )),
          ListTile(
            title: Text("Inicio"),
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          ListTile(
            title: Text("Categorías"),
            onTap: () {
              Navigator.pushNamed(context, "/categories");
            },
          ),
          ListTile(
            title: Text("Productos"),
            onTap: () {
              Navigator.pushNamed(context, "/products");
            },
          ),
          ListTile(
            title: Text("Historial"),
            onTap: () {
              Navigator.pushNamed(context, "/history");
            },
          ),
        ],
      ),
    );
  }
}
