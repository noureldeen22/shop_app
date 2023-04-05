import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/componets.dart';


class FavoritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: Text(
          'favorites screen is empty',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
        ),
      ),
    );
  }
}

// return BlocConsumer<ShopCubit, ShopStates>(
// listener: (context, state) {},
// builder: (context, state)
// {
// return ConditionalBuilder(
// condition: state is! ShopLoadingGetFavoritesState,
// builder: (context) => ListView.separated(
// itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data[index].product, context),
// separatorBuilder: (context, index) => myDivider(),
// itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
// ),
// fallback: (context) => Center(child: CircularProgressIndicator()),
// );
// },
// );