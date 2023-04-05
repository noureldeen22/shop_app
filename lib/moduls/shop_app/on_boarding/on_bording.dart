import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/componets.dart';
import '../../../shared/styles/colours/colors.dart';
import '../login/shop_login.dart';
class BoardingModel
{
  final image;
  final title;
  final body;
  BoardingModel(
  {
    required this.image,
    required this.title,
    required this.body,
});
}


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/bo.jpg',
        title: 'WELLCOME TO NOUNS STORE !',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/images/bo.jpg',
        title: 'SAVE  MONEY!',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/images/bo.jpg',
        title: 'FAST  DELIVERY!',
        body: 'On Board 3 body'),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true).then((value)
    {
      if (value)
      {
        navigateAndFinish(
            context,
            ShopLoginScreen());
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
              {
                submit;
                navigateTo(context, ShopLoginScreen());
              },
              child: Text('SKIP',
              style: TextStyle(
                color: Colors.red
              ),))
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                  {
                    if(index == boarding.length - 1)
                    {
                        setState(()
                        {
                          isLast = true;
                        });
                    }else
                      setState(() {
                        isLast = false;
                      });
                  },
                controller: BoardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder:(context,index) => buildBoardingItem(boarding[index]),
                  itemCount: boarding.length
              ),),
            SizedBox(
              height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: BoardController,
                    effect: WormEffect(
                      type: WormType.thin,
                      activeDotColor: defaultColor,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: ()
                  {
                    if (isLast)
                    {
                      submit;
                      navigateAndFinish(context, ShopLoginScreen());
                    }else
                      {
                        BoardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                  },
                child:
                  Icon(Icons.arrow_forward_ios_rounded),)

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Expanded(
    child: Image(
    image: AssetImage('${model.image}'),
    ),
  ),
  Text('${model.title}',
  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),),
  SizedBox(
  height: 25),
  Text('${model.body}',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
    SizedBox(
        height: 25),
  ]
  );
}
