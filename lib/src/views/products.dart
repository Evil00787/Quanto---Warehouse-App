import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ium_warehouse/src/logic/cubit/offline/offline_cubit.dart';
import 'package:ium_warehouse/src/logic/cubit/products/products_cubit.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';
import 'package:ium_warehouse/src/widgets/custom_toast.dart';
import 'package:ium_warehouse/src/widgets/list_product.dart';
import 'package:ium_warehouse/src/widgets/manufacturer_section.dart';
import 'package:ndialog/ndialog.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage();

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<ProductsPage> {
  Map<ManufacturerSection, List<ListProduct>> _section = {};
  bool canUpdate = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<OfflineCubit, OfflineState>(
          builder: (context, networkState) {
            return BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {
                if(state is ProductsSuccess)
                  setState(() {
                    _section = _getProductList(state);
                  });
                else if(state is ProductsError && canUpdate) {
                  CustomToast(
                    state.message,
                    Icons.error_outline,
                    Colors.red,
                  ).show(context);
                  setState(() {
                    BlocProvider.of<ProductsCubit>(context).getProducts();
                  });
                }

                else if(state is ProductsUpdateSuccess) {
                  CustomToast(
                    "Success",
                    Icons.done_outlined,
                    Colors.green[300],
                  ).show(context);
                  setState(() {
                    BlocProvider.of<ProductsCubit>(context).getProducts();
                  });
                }

              },
              builder: (context, state) {
                if (state is ProductsInitial) {
                  BlocProvider.of<ProductsCubit>(context).getProducts();
                  return Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Warehouse",
                            style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 48),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (networkState as OfflineStateAll).isOnline ? "Online" : "Offline",
                                style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 20),
                              ),
                              Switch(
                                value: (networkState as OfflineStateAll).isOnline,
                                onChanged: (value) => onChangedSwitch(value),
                                activeColor: AppColors.mainColor,
                                activeTrackColor: AppColors.accentColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.moreWhite))
                      ),
                    ],
                  );
                }
                else if (state is ProductsError)
                  return Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Warehouse",
                            style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 48),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (networkState as OfflineStateAll).isOnline ? "Online" : "Offline",
                                style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 20),
                              ),
                              Switch(
                                value: (networkState as OfflineStateAll).isOnline,
                                onChanged: (value) => onChangedSwitch(value),
                                activeColor: AppColors.mainColor,
                                activeTrackColor: AppColors.accentColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.moreWhite), )
                      ),
                    ],
                  );
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: new ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _section.length + 1,
                      itemBuilder: (context, index) {
                        if(index == 0)
                          return Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    "Warehouse",
                                    style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 48),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (networkState as OfflineStateAll).isOnline ? "Online" : "Offline",
                                        style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 20),
                                      ),
                                      Switch(
                                        value: (networkState as OfflineStateAll).isOnline,
                                        onChanged: (value) => onChangedSwitch(value),
                                        activeColor: AppColors.mainColor,
                                        activeTrackColor: AppColors.accentColor,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        return new StickyHeader(
                          header: _section.keys.toList()[index -1],
                          content: Column(
                            children: _section.entries.toList()[index-1].value
                          )
                        );
                      }
                    ),
                  ),
                );
              }
            );
          }
        )
      ],
    );
  }

  Map<ManufacturerSection, List<ListProduct>> _getProductList(ProductsSuccess state) {
    List<UIProduct> sortedProducts = state.products;
    sortedProducts.sort((a, b) {
      return a.manufacturer.toString().toLowerCase().compareTo(b.manufacturer.toString().toLowerCase());
    });
    Map<ManufacturerSection, List<ListProduct>> map = {};
    List<ListProduct> list = [];
    UIProduct old;
    int i = 0;
    for (UIProduct product in sortedProducts) {
      if ((old != null && old.manufacturer != product.manufacturer)) {
        map[ManufacturerSection(old.manufacturer)] = list;
        list = [];
      }
      list.add(ListProduct(product));
      old = product;
      if(i+1 == sortedProducts.length)
        map[ManufacturerSection(old.manufacturer)] = list;
      i++;
    }
    return map;
  }



  Future<void> onChangedSwitch(bool value) async {
    BlocProvider.of<OfflineCubit>(context).setConnectionState(value);
    if(value) {
      setState(() {
        canUpdate = false;
      });
      await BlocProvider.of<ProductsCubit>(context).doOnlineStuff();
      if(BlocProvider.of<ProductsCubit>(context).add.isNotEmpty || BlocProvider.of<ProductsCubit>(context).update.isNotEmpty || BlocProvider.of<ProductsCubit>(context).delete.isNotEmpty || BlocProvider.of<ProductsCubit>(context).quantity.isNotEmpty)
        DialogBackground(
          dialog: SizedBox(
            height: 900,
            width: 400,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Card(
                color: AppColors.accentColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Synchronization errors", style: Theme.of(context).textTheme.headline1.copyWith(color: AppColors.evenMoreWhite)),
                        ),
                        Column(
                          children: [
                            for (var th in BlocProvider.of<ProductsCubit>(context).add)
                              Column(
                                children: [
                                  await BlocProvider.of<ProductsCubit>(context).getProduct(th[3]) != null ? ListProduct(await BlocProvider.of<ProductsCubit>(context).getProduct(th[3]))
                                  : Card(
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(th[0] + " " + th[1] + " - " + "Price: " + th[2], style: Theme.of(context).textTheme.headline3.copyWith(color: AppColors.accentColor), textAlign: TextAlign.center,),
                                  )),
                                  ),
                                  Center(child: Text(
                                    "ADDING FAILED",
                                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColors.evenMoreWhite),
                                  ))
                                ],
                              ),
                            for (var th in BlocProvider.of<ProductsCubit>(context).update)
                              Column(
                                children: [
                                  await BlocProvider.of<ProductsCubit>(context).getProduct(th[3]) != null ? ListProduct(await BlocProvider.of<ProductsCubit>(context).getProduct(th[3]))
                                  : ListProduct(th[4], isDeleted: true),
                                  Center(child: Text(
                                    "Update " + th[0] + " " + th[1] + " - " + "Price: " + th[2] + "FAILED",
                                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColors.evenMoreWhite),
                                  ))
                                ],
                              ),
                            for (var th in BlocProvider.of<ProductsCubit>(context).delete)
                              Column(
                                children: [
                                  await BlocProvider.of<ProductsCubit>(context).getProduct(th[0]) != null ? ListProduct(await BlocProvider.of<ProductsCubit>(context).getProduct(th[0]))
                                  :ListProduct(th[1], isDeleted: true),
                                  Center(child: Text(
                                    "Already deleted",
                                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColors.evenMoreWhite),
                                  )),
                                ],
                              ),
                            for (var th in BlocProvider.of<ProductsCubit>(context).quantity)
                              Column(
                                children: [
                                  await BlocProvider.of<ProductsCubit>(context).getProduct(th[0]) != null ? ListProduct(await BlocProvider.of<ProductsCubit>(context).getProduct(th[0]))
                                  : ListProduct(th[2], isDeleted: true),
                                  Center(child: Text(
                                    "Change quantity: " + th[1].toString() + " FAILED",
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColors.evenMoreWhite),
                                  )),
                                ],
                              ),
                          ],
                        ),
                        Padding(
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
                                  "OK",
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ).show(context);
      BlocProvider.of<ProductsCubit>(context).add.clear();
      BlocProvider.of<ProductsCubit>(context).update.clear();
      BlocProvider.of<ProductsCubit>(context).delete.clear();
      BlocProvider.of<ProductsCubit>(context).quantity.clear();
      setState(() {
        canUpdate = true;
        BlocProvider.of<ProductsCubit>(context).getProducts();
      });
    }
  }
}
