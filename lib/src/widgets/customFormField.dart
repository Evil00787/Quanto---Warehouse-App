import 'package:flutter/material.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isHidden;

  const CustomFormField(this.label, this.icon, {this.isHidden = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: false,
      style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.notBlack),
      obscureText: isHidden,
      decoration: InputDecoration(
        labelText: label,
        icon: Icon(icon),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
            color: AppColors.accentColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
            color: AppColors.slightlyGray,
          ),
        ),
      ),
    );
  }
}
