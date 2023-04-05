
import '../../../../layout/shop_app/login_model.dart';


abstract class ShopLoginStates{}

class SocialLoginInitialState extends ShopLoginStates{}

class SocialLoginSuccessState extends ShopLoginStates
{
  final SocialLoginModel loginModel;

  SocialLoginSuccessState(this.loginModel);
}

class SocialLoginLoadingState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error;

  ShopLoginErrorState(this.error);
}
class ShopPasswordShowState extends ShopLoginStates{}