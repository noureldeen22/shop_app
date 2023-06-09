import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../../moduls/Favourites/Favourits.dart';
import '../../../moduls/Settings/settings.dart';
import '../../../moduls/categogries/Categogries.dart';
import '../../../moduls/prouducts/products.dart';
import '../../../network/end_point.dart';
import '../../../network/remote/dio_helper.dart';
import '../../../shared/constants.dart';
import '../categories_model.dart';
import '../change_favorites_model.dart';
import '../favorites_model.dart';
import '../home_model.dart';
import '../login_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super (ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> BottomScreens =
  [
    ProductsScreen(),
    CategeoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      
      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll(
          {
            element.id! : element.inFavorites!,
          }
        );
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {

    DioHelper.getData(
        url: GET_CATEGORIES,
        token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel ;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data:{
        'product_id': productId
      },
      token: token,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel!.status!)
        {
          favorites[productId] = !favorites[productId]!;
        }else
          {
            getFavorites();
          }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((e)
    {
      emit(ShopErrorChangeFavoritesState());
    });
  }


  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(favoritesModel!.data!.data.toString());
      emit(ShopSuccessGetFavoritesState());

    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  SocialLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = SocialLoginModel.fromJson(value.data);
      printFullText(userModel!.data.toString());
      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData(
  {
  required String name,
  required String email,
  required String phone,
}
      )
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
    ).then((value) {
      userModel = SocialLoginModel.fromJson(value.data);
      printFullText(userModel!.data.toString());
      emit(ShopSuccessUpdateUserState(userModel!));

    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}