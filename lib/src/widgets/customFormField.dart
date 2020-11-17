import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isHidden;
  final Function(String) onSaved;
  final TextEditingController controller;
  final bool isDouble;
  final bool isNumber;
  final bool isEmail;
  final Function(String) validator;

  const CustomFormField(this.label, this.icon,{ this.onSaved, this.isHidden = false, this.controller, this.isDouble = false, this.isEmail = false, this.isNumber = false, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.notBlack),
      obscureText: isHidden,
      onChanged: onSaved,
      controller: controller,
      keyboardType: isDouble || isNumber ? TextInputType.number : isEmail ? TextInputType.emailAddress : TextInputType.text,
      inputFormatters: <TextInputFormatter>[
        if(isDouble) FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      validator: validator == null ? ((val) => val.isEmpty ? 'Field cannot be blank' : null) : validator,
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
