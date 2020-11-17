import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/views/account.dart';
import 'package:ium_warehouse/src/views/add_product.dart';
import 'package:ium_warehouse/src/views/dashboard.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar(this.changeContent);
  final Function(int) changeContent;

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      backgroundColor: Colors.white,
      selectedBackgroundColor: AppColors.mainColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: AppColors.mainColor,
      currentIndex: _current,
      onTap: (int val) {
        if(val == 0)
          DashboardPage();
        if(val == 1)
          AddProductPage();
        if(val == 2)
          AccountPage();
        setState(() {
          _current = val;
        });
        widget.changeContent(val);
      },
      items: [
        FloatingNavbarItem(icon: Icons.home, title: 'Home'),
        FloatingNavbarItem(icon: Icons.add, title: 'Add product'),
        FloatingNavbarItem(icon: Icons.person, title: 'Account'),
      ],
    );
  }
}
