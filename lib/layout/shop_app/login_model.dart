class SocialLoginModel
{
  bool? status;
  String? message;
  UserData? data;

  SocialLoginModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData
{
  int? id;
  int? points;
  int? credit;
  int? phone;
  String? name;
  String? email;
  String? image;
  String? token;


//   UserData(
//   {this.id,
//     this.points,
//     this.credit,
//     this.phone,
//     this.name,
//     this.email,
//     this.image,
//     this.token,
// });

  UserData.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    points = json['points'];
    credit = json['credit'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
  }
}