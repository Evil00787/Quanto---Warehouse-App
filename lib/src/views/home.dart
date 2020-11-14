import 'package:flutter/material.dart';
import 'package:ium_warehouse/routing/routes.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';

class HomePage extends StatelessWidget {
  static final String title = "Quanto";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red]
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Center(
                    child: Image.asset('assets/images/quanto.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                    child: Text(
                      "Quanto",
                      style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 72),
                    ),
                  )
                ],
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: AppColors.notWhite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                  child: Text("SIGN IN", style: AppFonts.buttonFont.copyWith(color: AppColors.accentColor)),
                ),
                onPressed: () => Navigator.pushNamed(context, AppRoute.login.name),
              )
            ],
          ),
        ),
      ),
    );
  }
}

