import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ium_warehouse/src/logic/cubit/products/products_cubit.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';
import 'package:ium_warehouse/src/widgets/gradient_button.dart';

class EditQuantity extends StatefulWidget {
  final UIProduct uiProduct;

  EditQuantity(this.uiProduct);

  @override
  _EditQuantityPageState createState() => _EditQuantityPageState();
}

class _EditQuantityPageState extends State<EditQuantity> {
  TextEditingController _value;



  @override
  void initState() {
    _value = TextEditingController();
    _value.text = 0.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.mainColor,
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
            child: Center(
              child: Form(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Edit quantity",
                        style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 48),
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
                            border: Border.all(color: AppColors.evenMoreWhite),
                            color: AppColors.evenMoreWhite,
                            borderRadius: BorderRadius.all(Radius.circular(18.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Text(widget.uiProduct.manufacturer + " " + widget.uiProduct.modelName, maxLines: 4, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline1,),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Text("In stock: " + widget.uiProduct.quantity.toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyText2,),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(child: GradientButton(() {_value.text = (int.parse(_value.text) - 1).toString();}, icon: Icons.remove, isCircle: true,)),
                                    Expanded(
                                      child: TextFormField(
                                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.notBlack, ),
                                        controller: _value,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                        ],
                                        decoration: InputDecoration(
                                          labelText: "Quantity",
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
                                      ),
                                    ),
                                    Expanded(child: GradientButton(() {_value.text = (int.parse(_value.text) + 1).toString();}, icon: Icons.add_outlined, isCircle: true,)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
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
                                              child: Icon(Icons.calculate_outlined, color: AppColors.moreWhite, size: 32,),
                                            ),
                                            Text(
                                              "UPDATE",
                                              textAlign: TextAlign.center,
                                              style: AppFonts.buttonFont,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: onChangeQuantity,
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
          )
        )
      )
    );
  }

  void onChangeQuantity() {
    BlocProvider.of<ProductsCubit>(context).changeQuantity(widget.uiProduct.id, int.parse(_value.text));
    Navigator.pop(context);
  }
}
