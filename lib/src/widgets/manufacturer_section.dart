import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';

class ManufacturerSection extends StatelessWidget {
  final String manufacturer;

  const ManufacturerSection(this.manufacturer);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: GradientCard(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          gradient: LinearGradient(
            colors: [ Colors.red[300], Colors.blue[300]],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
            child: Center(
              child: Text(
                manufacturer, style: Theme.of(context).textTheme.headline1.copyWith(color: AppColors.moreWhite, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
