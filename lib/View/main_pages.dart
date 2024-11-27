import 'package:eduasses360/view_model/main_pages_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPages extends StatelessWidget {
  @override
  Widget build(BuildContext context){

    final mainPageProvider = Provider.of<MainPagesViewModel>(context);

    return Scaffold(
      body: mainPageProvider.pages[mainPageProvider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          mainPageProvider.selectIndex(0);
        },
        backgroundColor: Colors.white70,
        elevation: 25,
        enableFeedback: true,
        showSelectedLabels: true,
          showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: "Home",
          tooltip: "Homa Page"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),
              label: "Notifications",
              tooltip: "Notifications"
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person),
              label: "Profile",
              tooltip: "Profile"
          ),
        ],
      )
    );
  }
}