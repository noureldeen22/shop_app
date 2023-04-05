import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colours/colors.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

import '../layout/shop_app/cubit/cubit.dart';


// Widget buildArticleItem(article,context) => InkWell(
//   onTap: ()
//   {
//     navigateTo(context, WebViewScreen(article['url']));
//   },
//   child:   Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//         Container(
//           width: 120,
//           height: 120,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             image: DecorationImage(image:
//             NetworkImage('${article['urlToImage']}'),
//                 fit: BoxFit.cover),
//
//           ),
//         ),
//         SizedBox(
//           width: 10,),
//         Expanded(
//           child: Container(
//             height: 120,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children:
//               [
//                 Expanded(
//                   child: Text(
//                     '${article['title']}',
//                     style: Theme.of(context).textTheme.bodyText1,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//
//                 Text(
//                     '${article['publishedAt']}',style: TextStyle(fontSize: 17
//                     ,color: Colors.grey))
//               ],
//             ),
//           ),
//         )
//       ],
//     ),
//   ),
// );

Widget myDivider () =>  Padding(
  padding:const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[300],
  ),);

// Widget articleBuilder(list,context, {isSearch = false}) => ConditionalBuilder(
//     condition: list.length > 0,
//     builder: (context) => ListView.separated(
//       physics: BouncingScrollPhysics(),
//       itemBuilder: (context,index) => buildArticleItem(list[index],context),
//       separatorBuilder:(context,index) => myDivider(),
//       itemCount: 10,
//     ),
//     fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator())
// );

void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(
    builder:(context) => widget,
    ),
);

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute( builder:(context) => widget,
    ), (route) {
  return false;
});

void showToast(
{
  required String text,
  required ToastStates state,
}) =>  Fluttertoast.showToast(
msg:text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
    color = Colors.green;
    break;
    case ToastStates.ERROR:
    color =Colors.red;
    break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}

Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String? label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) => TextFormField(
  controller: control,
  keyboardType: type,
  validator: validator,
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onTap: () {},
  obscureText: isPassword,
  onChanged: (value) {
    onChanged!(value);
  },
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: () {
          suffixClicked!();
        },
        icon: Icon(suffix),
      )
          : null,
      border: OutlineInputBorder()),
);

Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = defaultColor,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() onTap,
  required String text,
}) => Container(
    width: width,
    height: 40,
    decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(radius)),
    child: MaterialButton(
      onPressed: onTap,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
            fontSize: 18, color: Colors.white, ),
      ),
    ));

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon:Icon(
          IconBroken.Arrow___Left_Circle )),

       title: Text(
         title!),
       actions: actions,
);


Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favorites[model.id]!
                              ? defaultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );