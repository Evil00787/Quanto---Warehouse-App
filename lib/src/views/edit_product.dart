import 'package:flutter/material.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/widgets/product_form.dart';

class EditProductPage extends StatefulWidget {
  final UIProduct uiProduct;

  EditProductPage(this.uiProduct);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {



  @override
  void initState() {
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
                        "Edit product",
                        style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 48),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                      ProductForm(isUpdate: true, product: widget.uiProduct),
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
}
