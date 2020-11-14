import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String titleString;

  CustomAppBar(this.titleString);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(titleString),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search,
              size: 26.0,
            ),
          )
        ),
      ],
    );
  }
}
