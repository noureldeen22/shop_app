
import '../../../../layout/shop_app/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates
{
  final SocialLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error;

  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates{}