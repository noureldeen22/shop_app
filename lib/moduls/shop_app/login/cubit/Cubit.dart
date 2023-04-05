import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/moduls/shop_app/login/cubit/states.dart';
import '../../../../layout/shop_app/login_model.dart';
import '../../../../network/end_point.dart';
import '../../../../network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit <ShopLoginStates>
{
  ShopLoginCubit() : super(SocialLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  SocialLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(SocialLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }).then((value)
    {
      print(value.data);
      loginModel = SocialLoginModel.fromJson(value.data);
      emit(SocialLoginSuccessState(loginModel!));
    }).catchError((error)
    {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye_outlined :Icons.remove_red_eye_rounded;
    emit(ShopPasswordShowState());
  }
}