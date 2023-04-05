import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrumlab_colored_progress_indicators/scrumlab_colored_progress_indicators.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/componets.dart';
import '../../shared/constants.dart';

class SettingsScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
   return BlocConsumer<ShopCubit,ShopStates>
      (
          listener: (context ,state)
          {
            // if(state is ShopSuccessUserDataState)
            // {
            //   print(state.loginModel.data!.email);
            //   print(state.loginModel.data!.name);
            //   print(state.loginModel.data!.phone);
            //
            //   nameController.text = state.loginModel.data!.name!;
            //   emailController.text = state.loginModel.data!.email!;
            //   phoneController.text = state.loginModel.data!.phone! as String;
            // }
          },
          builder: (context ,state)
          {
            return ConditionalBuilder(
             condition: ShopCubit.get(context).userModel != null,
              builder: (context) =>   Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                defaultFormText(
                control: nameController,
                type: TextInputType.name,
                validator: (String? value)
                {
                if(value!.isEmpty)
                {
                return 'name must not be empty';
                }
                return null;
                },
                label: 'Name',
                prefix: Icons.person),
                SizedBox(
                height: 20,
                ),

                defaultFormText(
                control: emailController,
                type: TextInputType.emailAddress,
                validator: (String? value)
                {
                if(value!.isEmpty)
                {
                return 'email must not be empty';
                }
                return null;
                },
          label: 'Email Address',
          prefix: Icons.email_outlined),
          SizedBox(
          height: 20,
                ),

                defaultFormText(
                control: phoneController,
                type: TextInputType.phone,
          validator: (String? value)
                {
                if(value!.isEmpty)
                {
                return 'phone number must not be empty';
                }
                return null;
                },
          label: 'Phone Number',
          prefix: Icons.phone),

                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      onTap: ()
                      {
                        signOut(context);
                      },
                      text: 'Log out'),

                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      onTap: ()
                      {
                        if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                      },
                      text: 'Update  Information'),
          ],
          ),
              ),
            ),
          ),
              fallback: (context) => Center(child: ColoredCircularProgressIndicator()),

            );
          },
   );
  }
}
