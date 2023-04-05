import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constants.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/states.dart';
import 'layout/shop_app/shop_layout.dart';
import 'moduls/shop_app/login/shop_login.dart';
import 'moduls/shop_app/on_boarding/on_bording.dart';
import 'shared/bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  final isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  final onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  } else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    // isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build
  // final bool isDark;
  final Widget startWidget;

  MyApp({
    // required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),

      child:BlocConsumer<ShopCubit,ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: Colors.red,
                  appBarTheme: AppBarTheme(
                    centerTitle: true,
                    elevation: 0,
                    color: Colors.white
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    elevation: 0,
                    selectedItemColor: Colors.redAccent,
                    unselectedItemColor: Colors.red.shade200
                  ),

                ),
                home: startWidget
            );  }
      ),
    );
  }
}