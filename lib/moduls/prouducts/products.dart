import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/styles/colours/colors.dart';
import '../../layout/shop_app/categories_model.dart';
import '../../layout/shop_app/home_model.dart';
import '../../shared/componets.dart';
class ProductsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoritesState)
          {
            if(!state.model.status!)
              {
                showToast(
                    text: state.model.massage!,
                    state: ToastStates.SUCCESS);
              }
          }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) => builderWidget(ShopCubit.get(context).homeModel , ShopCubit.get(context).categoriesModel!,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(HomeModel? model, CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items: model!.data!.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 3,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Categories',
              maxLines: 1,
              style: TextStyle(
                color: Colors.red.shade500,
                fontWeight: FontWeight.w400,
                fontSize: 24,
              ),),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) => buildCategoryItem( categoriesModel.data!.data![index]),
                    separatorBuilder:  (context,index) => SizedBox(width: 7,),
                    itemCount: categoriesModel!.data!.data!.length),
              ),
              SizedBox(
                height: 18,
              ),
              Text
                ('New Products',
              maxLines: 1,
              style: TextStyle(
                color: Colors.red.shade500,
               fontWeight: FontWeight.w400,
               fontSize: 24),),
            ],
          ),
        ),
        SizedBox(
            height: 10),
        Container(
          color: Colors.grey[200],
          child: GridView.count(
            shrinkWrap: true,
             mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.68 ,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount:2,
            children: List.generate(model.data!.products.length, (index) =>
              buildGridProduct(model.data!.products[index],context)  )
          ),
        ),
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model) =>  Stack(alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(model.image!),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
          color: Colors.black.withOpacity(0.6),
          width: 100,
          child: Text(model.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center
            ,style:
            TextStyle(
              color: Colors.white,),)),
    ],
  );

  Widget buildGridProduct(ProductModel model,context) => Container(
    color: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(image: NetworkImage(model.image!),
                width: double.infinity,
                height: 200,),
          if (model.discount != 0)
          Container(
            color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('DISCOUNT',
                style: TextStyle(color: Colors.white,fontSize: 10),
              ),
              )
              ],
            ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2 ,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(fontSize: 14,color: Colors.green),

                    ),
                    SizedBox(width: 12, ),
                    if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(fontSize: 11,color: Colors.grey,
                      decoration: TextDecoration.lineThrough),

                    ),
                    Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 18,
                          backgroundColor: ShopCubit.get(context).favorites[model.id!]!
                              ? defaultColor : Colors.white,
                          child: Icon(Icons.favorite_border,
                          size: 15,),
                        ))

                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}