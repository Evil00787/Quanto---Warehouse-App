import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ium_warehouse/routing/routes.dart';
import 'package:ium_warehouse/src/logic/cubit/auth/auth_cubit.dart';
import 'package:ium_warehouse/src/logic/cubit/products/products_cubit.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/utils/service_injection.dart';
import 'package:ium_warehouse/src/views/edit_quantity.dart';
import 'package:ium_warehouse/src/views/account.dart';
import 'package:ium_warehouse/src/views/add_product.dart';
import 'package:ium_warehouse/src/views/dashboard.dart';
import 'package:ium_warehouse/src/views/edit_product.dart';
import 'package:ium_warehouse/src/views/login.dart';
import 'package:ium_warehouse/src/views/home.dart';

Future<void> main() async {
  injectServices();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(GoogleSignIn(), FirebaseAuth.instance),
        )
      ],
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quanto',
      initialRoute: '/login',
      routes: _getRoutes(),
      theme: _createAppTheme(),
    );
  }

  Map<String, WidgetBuilder> _getRoutes() {
    var getRoute = (BuildContext context) => ModalRoute.of(context);
    var getParams = (BuildContext context) => getRoute(context).settings.arguments;
    return {
      AppRoute.home.name : f(HomePage()),
      AppRoute.login.name : f(LoginPage()),
      AppRoute.dashboard.name : f(DashboardPage()),
      AppRoute.account.name : f(AccountPage()),
      AppRoute.add.name: f(AddProductPage()),
      AppRoute.edit.name: (context) => (EditProductPage(getParams(context))),
      AppRoute.quantity.name: (context) => (EditQuantity(getParams(context)))
    };
  }


  Widget Function(BuildContext) f(Widget page) {
    return (context) => page;
  }

  ThemeData _createAppTheme() {
    return ThemeData(
      primaryColor: AppColors.mainColor,
      fontFamily: 'Lato',
      textTheme: TextTheme(
        // Will probably change over time
        headline1: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: AppColors.darkTextColor), // Scaffold/appbar headline
        headline2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: AppColors.darkTextColor), // Main headline before lists
        headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: AppColors.darkTextColor), //For headers inside list elements
        subtitle2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: AppColors.mediumTextColor), // Little subtitle for headline2
        bodyText1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: AppColors.lightTextColor), // Classic body text on light background
        bodyText2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: AppColors.darkTextColor), // Classic body text on color
        button: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: AppColors.lightTextColor) // (Almost always white) button text
      ),
    );
  }
}

