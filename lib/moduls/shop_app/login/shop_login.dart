import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scrumlab_colored_progress_indicators/scrumlab_colored_progress_indicators.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/componets.dart';
import '../../../shared/constants.dart';
import '../../../shared/styles/colours/colors.dart';
import '../register/shop_register.dart';
import 'cubit/Cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context, state) {
            if ( state is SocialLoginSuccessState)
            {
              if (state.loginModel.status!)
              {
                print(state.loginModel.message);
                print(state.loginModel.data!.token);

                CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModel.data!.token
                ).then((value)
                {
                  token = state.loginModel.data!.token;

                  navigateAndFinish(
                    context,
                    ShopLayout(),);
                });
                showToast(
                    text: state.loginModel.message! ,
                    state: ToastStates.SUCCESS);
              } else
              {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message!,
                  state: ToastStates.ERROR,
              );
            }
          }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN', style: TextStyle(fontSize: 35),),
                          SizedBox(
                            height: 10,),
                          Text('login now to browse out hot offers', style:
                          TextStyle(fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: (Colors.grey)),),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'email must not be empty';
                              }
                            },
                            keyboardType: TextInputType.emailAddress,

                            decoration: InputDecoration(
                              label: Text('Email addres',
                                style: TextStyle(color: Colors.grey),),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),

                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            onFieldSubmitted: (value) {
                              navigateAndFinish(context, ShopLayout());
                            if(formKey.currentState!.validate())
                            {
                            ShopLoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text
                            );
                            }
                            },
                            obscureText: ShopLoginCubit.get(context).isPassword,
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password must not be empty';
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              label: Text('Password',
                                style: TextStyle(color: Colors.grey),),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon:IconButton(
                                  onPressed: ()
                                  {
                                    ShopLoginCubit.get(context).changePasswordVisibility();
                                  },
                                  icon: Icon( ShopLoginCubit.get(context).suffix ))
                              ),
                          ),
                          SizedBox(height: 30,),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => Container(
                              width: double.infinity,
                              color: defaultColor,
                              child:
                              MaterialButton(
                                onPressed: ()
                                {
                                  if(formKey.currentState!.validate())
                                    {
                                      navigateAndFinish
                                        (context, ShopLayout());
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,

                                      );
                                    }
                                  },
                                child:
                                Text('LOGIN',
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            fallback: (context) => Center(
                                child:ColoredCircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have account?',
                              ),
                              TextButton(onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                                child: Text(
                                  'REGISTER NOW',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100, fontSize: 13),

                                ),),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
  }
