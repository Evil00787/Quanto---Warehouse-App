import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ium_warehouse/routing/routes.dart';
import 'package:ium_warehouse/src/logic/cubit/auth/auth_cubit.dart';
import 'package:ium_warehouse/src/logic/cubit/products/products_cubit.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is AuthStateInitial) {
            BlocProvider.of<ProductsCubit>(context).resetState();
            Navigator.pushReplacementNamed(context, AppRoute.login.name);
          }
        },
        builder: (context, state) {
          if(state is AuthStateError || state is AuthStateInitial)
            return SizedBox.shrink();
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Account",
                    style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 48),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: AppColors.moreWhite,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(0),
                    onPressed: () => {},
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.person, color: AppColors.accentColor, size: 120,),
                    )
                  ),
                ),
                Text((state as AuthStateSuccess).user.email, style: Theme.of(context).textTheme.headline1.copyWith(color: AppColors.moreWhite)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                  child: RaisedButton(
                    color: AppColors.moreWhite,
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
                                child: Icon(Icons.login_outlined, color: AppColors.moreWhite, size: 32,),
                              ),
                              Text(
                                "LOGOUT",
                                textAlign: TextAlign.center,
                                style: AppFonts.buttonFont,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onPressed: () => BlocProvider.of<AuthCubit>(context).logoutUser(),
                  ),
                )
              ],
            ),
          );
        },
      );
  }
}
