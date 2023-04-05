import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrumlab_colored_progress_indicators/scrumlab_colored_progress_indicators.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/componets.dart';
import '../../../shared/constants.dart';
import '../../../shared/styles/colours/colors.dart';
import '../login/cubit/Cubit.dart';
import '../login/cubit/states.dart';
import 'cubit/Regester_Cubit.dart';
import 'cubit/Regester_states.dart';

class ShopRegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state)
        {
          if ( state is ShopRegisterSuccessState)
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
        builder: (context , state) {
          return Scaffold(
          appBar: AppBar(),
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
          'REGISTER', style: TextStyle(fontSize: 35),),
          SizedBox(
          height: 10,),
          Text('Register now to browse out hot offers', style:
          TextStyle(fontSize: 15,
          fontWeight: FontWeight.w200,
          color: (Colors.grey)),),
          SizedBox(height: 20,),
          TextFormField(
          controller: nameController,
          validator: (value) {
          if (value!.isEmpty) {
          return 'name must not be empty';
          }
          },
          keyboardType: TextInputType.name,

          decoration: InputDecoration(
          label: Text('User Name',
          style: TextStyle(color: Colors.grey),),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),

          ),
          ),
          SizedBox(height: 20,),
          TextFormField(
          controller: emailController,
          validator: (String? value) {
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
          defaultFormText(
              control: passwordController,
              type: TextInputType.visiblePassword,
              validator: (String? value) {
                if(value!.isEmpty)
                {
                    return 'add password';
                  }
              },
              suffix: ShopRegisterCubit.get(context).suffix,
              onSubmit: ()
              {

              },
              isPassword: ShopRegisterCubit.get(context).isPassword,
              label: 'password',
              prefix: Icons.lock_outline),
          SizedBox(height: 30,),
          TextFormField(
          controller: phoneController,
          validator: (value) {
          if (value!.isEmpty) {
          return 'phone number must not be empty';
          }
          },
          keyboardType: TextInputType.phone,

          decoration: InputDecoration(
          label: Text('Phone number',
          style: TextStyle(color: Colors.grey),),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.phone),

          ),
          ),
          SizedBox(
            height: 15,
          ),
          ConditionalBuilder(
          condition: state is! ShopRegisterLoadingState,
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
          ShopRegisterCubit.get(context).userRegister(
          email: emailController.text,
          password: passwordController.text,
            name: nameController.text,
            phone: phoneController.text,

          );
          }
          },
          child:
          Text('Login',
          style: TextStyle(
          color: Colors.white),
          ),
          ),
          ),
          fallback: (context) => Center(
          child:ColoredCircularProgressIndicator()),
          ),
          ],
          ),
          ),
          ),
          ),
          ),
          );
        },
      ),
    );
  }
}
