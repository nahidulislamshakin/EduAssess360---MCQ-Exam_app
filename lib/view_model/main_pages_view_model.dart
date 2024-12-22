import 'package:eduasses360/View/home_page/home_page.dart';
import 'package:eduasses360/View/student_profile_page.dart';
import 'package:flutter/material.dart';

class MainPagesViewModel with ChangeNotifier{
  final List _pages = [HomePage(),StudentProfilePage()];
  int _selectedIndex = 0;

  List get pages => _pages;
  int get selectedIndex => _selectedIndex;

  void selectIndex(int selectedIndex){
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

}