import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../layout/shop_app/login_model.dart';
import '../../../../network/end_point.dart';
import '../../../../network/remote/dio_helper.dart';
import 'Regester_states.dart';

class ShopRegisterCubit extends Cubit <ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  SocialLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }).then((value)
    {
      print(value.data);
      loginModel = SocialLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye_outlined :Icons.remove_red_eye_rounded;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}