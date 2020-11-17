import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ium_warehouse/src/logic/cubit/products/products_cubit.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/views/account.dart';
import 'package:ium_warehouse/src/views/add_product.dart';
import 'package:ium_warehouse/src/views/products.dart';
import 'package:ium_warehouse/src/widgets/nav_bar.dart';

class DashboardPage extends StatefulWidget {
  static final String title = "Quanto";

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: CustomNavBar(changeContent),
      backgroundColor: AppColors.moreWhite,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Colors.blue, Colors.red]),
          ),
          child: SafeArea(
            child: getPage()
          )
        )
      )
    );
  }

  void changeContent(int val) {
    setState(() {
      _page = val;
    });
  }

  Widget getPage() {
    if(_page == 0)
      return ProductsPage();
    BlocProvider.of<ProductsCubit>(context).resetState();
    if (_page == 1)
      return AddProductPage(redirect: changeContent);
    return AccountPage();
  }
}
