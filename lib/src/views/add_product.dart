import 'package:flutter/material.dart';
import 'package:ium_warehouse/src/widgets/custom_toast.dart';
import 'package:ium_warehouse/src/widgets/product_form.dart';


class AddProductPage extends StatefulWidget {
  final Function(int) redirect;

  const AddProductPage({this.redirect});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "New product",
                style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 48),
              ),
            ),
            ProductForm(onClick: onProductAdded,),
          ],
        ),
      )
    );
  }

  void onProductAdded() {
    CustomToast(
     "Product has been added",
      Icons.check_outlined,
      Colors.lightGreen[300],
    ).show(context);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    widget.redirect(0);
  }
}
