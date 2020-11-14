import 'package:flutter/material.dart';
import 'package:ium_warehouse/routing/routes.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';
import 'package:ium_warehouse/src/widgets/customFormField.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Colors.blue, Colors.red]),
        ),
        child: Center(
          child: Form(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Sign in",
                    style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 72),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600].withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 12,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                            border: Border.all(color: AppColors.notWhite),
                            color: AppColors.notWhite,
                            borderRadius: BorderRadius.all(Radius.circular(18.0))),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 8),
                                child: CustomFormField('Email', Icons.mail_outline)),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(32.0, 8, 32, 8),
                                child: CustomFormField('Password', Icons.lock_outline, isHidden: true,)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [ Colors.red[300], AppColors.accentColor],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(18.0)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Icon(Icons.login_outlined, color: AppColors.moreWhite, size: 32,),
                                          ),
                                          Text(
                                            "LOGIN",
                                            textAlign: TextAlign.center,
                                            style: AppFonts.buttonFont,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () => Navigator.pushNamed(context, AppRoute.login.name),
                              ),
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: RaisedButton(
                      color: AppColors.notWhite,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(0),
                      onPressed: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.arrow_back_outlined, color: AppColors.accentColor),
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
