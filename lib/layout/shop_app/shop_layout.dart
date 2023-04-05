

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';

import '../../moduls/search/search.dart';
import '../../shared/componets.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
    {
      var cubit = ShopCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
       title: Text(
        ' Store',
         style: TextStyle(
           color: Colors.red
         ),
      ),
          actions:
          [
            IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchShopScreen());
                },
                icon: Icon(Icons.search)),
          ],
       ),
        body: cubit.BottomScreens [cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index)
          {
            cubit.changeScreen(index);
          },
            currentIndex: cubit.currentIndex,
            items: 
            [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
              label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
              label: 'Categeories'),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
              label: 'Favorites'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
              label: 'Settings'),
            ]),

    );
    },
    );
}
}