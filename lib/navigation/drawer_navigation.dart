import 'package:flutter/material.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          UserAccountsDrawerHeader(
            accountEmail: Text("dineshkumar.mohandos@gmail.com"),
            accountName: Text("Dinesh_Ravan_"),
            currentAccountPicture: CircleAvatar(
              foregroundImage: NetworkImage(
                  "https://w0.peakpx.com/wallpaper/980/646/HD-wallpaper-neon-thor-marvel-god-f-thunder-thor-ragnarok-artwork.jpg"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.video_collection_outlined),
            title: Text("Shorts"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
