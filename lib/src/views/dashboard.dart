import 'package:flutter/material.dart';
import 'package:ium_warehouse/src/widgets/app_bar.dart';

class DashboardPage extends StatelessWidget {
  static final String title = "Quanto";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title)
        ],
      ),
    );
  }
}
