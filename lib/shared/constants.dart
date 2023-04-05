// POST
// UPDATE
// DELETE
//
// GET
//

// api key = 47c7c97d494c47aba5d88188cb661e04

// base url = https://newsapi.org/
// method = v2/top-headlines
// quireis = country=eg
//           category=business
//           apiKey= 47c7c97d494c47aba5d88188cb661e04
import '../moduls/shop_app/login/shop_login.dart';
import '../network/local/cache_helper.dart';
import 'componets.dart';

void signOut (context)
{
  CacheHelper.removeData(key: 'token',).then((value) {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';

String? uId = '';

// dynamic token = '';