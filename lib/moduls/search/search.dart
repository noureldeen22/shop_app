import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../shared/componets.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchShopScreen extends StatelessWidget {
  @override
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state)
        {

        },
        builder: (context,state)
        {
          return Scaffold(
              appBar: AppBar(),
              body:Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormText(
                        onSubmit: (String text)
                          {
                            SearchCubit.get(context).search(text);
                          },
                          control: searchController,
                          type: TextInputType.text,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                              {
                                return 'search must noy empty';
                              }
                            return null;
                          },
                          label: 'Search',
                          prefix: Icons.search),
                      SizedBox(
                        height: 10,
                      ),
                      if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data[index],context,isOldPrice: false,),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context).model!.data!.data.length,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
