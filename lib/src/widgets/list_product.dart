import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ium_warehouse/routing/routes.dart';
import 'package:ium_warehouse/src/logic/cubit/auth/auth_cubit.dart';
import 'package:ium_warehouse/src/logic/cubit/products/products_cubit.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/models/ui/user.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';
import 'package:ndialog/ndialog.dart';


class ListProduct extends StatefulWidget {
  final UIProduct uiProduct;

  const ListProduct(this.uiProduct);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  bool canDelete;

  @override
  Widget build(BuildContext context) {
    canDelete = (BlocProvider.of<AuthCubit>(context).state as AuthStateSuccess).user.role != Role.Employee;
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actions: canDelete ? [_getItem(Icons.delete_outline, 'Delete', _onProductDelete, Colors.redAccent)] : null,
      secondaryActions: [_getItem(Icons.edit_outlined, 'Edit', onEditForm, Colors.blue)],
      child: _mainCard()
    );
  }

  Widget _mainCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: InkWell(
          splashColor: AppColors.slightlyGray,
          focusColor: AppColors.evenSlighterGray,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          onTap: onQuantityForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                        child: Text(
                          widget.uiProduct.modelName, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.headline3
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                        child: Text(
                          "Price: " + widget.uiProduct.price.toString(), style: Theme.of(context).textTheme.subtitle2
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "Quantity", style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          widget.uiProduct.quantity.toString(), style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ],

                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _getItem(IconData icon, String text, Function onTap, Color color) {
    return Card(
      elevation: 4,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: IconSlideAction(
          caption: text,
          color:color,
          icon: icon,
          onTap: onTap,
        ),
      ),
    );
  }

  void _onProductDelete() {
    DialogBackground(
      dialog: SizedBox(
        height: 220,
        width: 400,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Deleting a product", style: Theme.of(context).textTheme.headline1,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Are you sure you want to delete this product?", style: Theme.of(context).textTheme.bodyText2,),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [ Colors.blue[300], Colors.blueAccent[400]],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(18.0)),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: Text(
                                "CANCEL",
                                textAlign: TextAlign.center,
                                style: AppFonts.buttonFont,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
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
                              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: Text(
                                "DELETE",
                                textAlign: TextAlign.center,
                                style: AppFonts.buttonFont,
                              ),
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<ProductsCubit>(context).deleteProduct(widget.uiProduct.id);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ).show(context);

  }



  void onEditForm() {
    Navigator.of(context).pushNamed(AppRoute.edit.name, arguments: widget.uiProduct);
  }

  void onQuantityForm() {
    Navigator.of(context).pushNamed(AppRoute.quantity.name, arguments: widget.uiProduct);
  }
}
