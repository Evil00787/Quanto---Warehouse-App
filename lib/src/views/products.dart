import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ium_warehouse/src/logic/cubit/products/products_cubit.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/widgets/list_product.dart';
import 'package:ium_warehouse/src/widgets/manufacturer_section.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage();

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<ProductsPage> {
  Map<ManufacturerSection, List<ListProduct>> _section = {};


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            if(state is ProductsSuccess)
              setState(() {
                _section = _getProductList(state);
              });
          },
          builder: (context, state) {
            if (state is ProductsInitial) {
              BlocProvider.of<ProductsCubit>(context).getProducts();
              return SizedBox.shrink();
            }
            else if (state is ProductsError)
              return SizedBox.shrink();
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _section.length + 1,
                  itemBuilder: (context, index) {
                    if(index == 0)
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Warehouse",
                            style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 48),
                          ),
                        ),
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
}
