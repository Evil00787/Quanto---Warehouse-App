import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ium_warehouse/src/logic/cubit/products/products_cubit.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';

import 'customFormField.dart';

class ProductForm extends StatefulWidget {
  final bool isUpdate;
  final Widget addWidget;
  final Function onClick;
  final UIProduct product;

  const ProductForm({this.isUpdate = false, this.addWidget, this.onClick, this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  TextEditingController _man;
  TextEditingController _model;
  TextEditingController _price;

  @override
  void initState() {
    if(widget.isUpdate) {
      _man = TextEditingController();
      _man.text = widget.product.manufacturer;
      _model = TextEditingController();
      _model.text = widget.product.modelName;
      _price = TextEditingController();
      _price.text = widget.product.price.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          border: Border.all(color: AppColors.evenMoreWhite),
          color: AppColors.evenMoreWhite,
          borderRadius: BorderRadius.all(Radius.circular(18.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 8),
              child: CustomFormField('Manufacturer', Icons.business_center, controller: _man)),
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 8, 32, 8),
              child: CustomFormField('Model', Icons.article_outlined, controller: _model,)),
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 8, 32, 8),
              child: CustomFormField('Price', Icons.local_atm_outlined, controller: _price,)),
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
                            child: Icon(widget.isUpdate ? Icons.update_outlined : Icons.add_outlined, color: AppColors.moreWhite, size: 32,),
                          ),
                          Text(
                            widget.isUpdate ? "UPDATE" : "ADD",
                            textAlign: TextAlign.center,
                            style: AppFonts.buttonFont,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onPressed: onFormButtonPressed,
              ),
            )
          ],
        )),
    );
  }

  void onFormButtonPressed() {
    if(widget.isUpdate) {
      BlocProvider.of<ProductsCubit>(context).updateProduct(_man.text, _model.text, _price.text, widget.product.id);
      Navigator.of(context).pop();

    }
    else {
      BlocProvider.of<ProductsCubit>(context).addProduct(_man.text, _model.text, _price.text, widget.product.id);
    }
    if(widget.onClick != null) widget.onClick();
  }



}
