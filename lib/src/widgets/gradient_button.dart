import 'package:flutter/material.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';

class GradientButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final IconData icon;
  final bool isCircle;

  const GradientButton(this.onPressed, {this.text, this.icon, this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
                  icon != null ?
                  Icon(icon, color: AppColors.moreWhite, size: 32,) : SizedBox.shrink(),
                  if(icon != null && text != null) Padding(padding: EdgeInsets.only(right: 8),),
                  text != null ?
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppFonts.buttonFont,
                  ) : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
