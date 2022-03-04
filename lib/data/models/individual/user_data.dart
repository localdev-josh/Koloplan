import 'package:hive/hive.dart';

part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  String uid;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  @HiveField(3)
  String email;
  @HiveField(4)
  String userType;
  @HiveField(5)
  String profilePhoto;
  @HiveField(6)
  String referralCode;
  @HiveField(7)
  String phoneNumber;

  UserData({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.userType,
    this.profilePhoto,
    this.referralCode,
    this.phoneNumber,
  });

  Map toMap(UserData user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['firstName'] = user.firstName;
    data['lastName'] = user.lastName;
    data['email'] = user.email;
    data['userType'] = user.userType;
    data["profilePhoto"] = user.profilePhoto;
    data["referralCode"] = user.referralCode;
    data["phoneNumber"] = user.phoneNumber;
    return data;
  }

  UserData.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.firstName = mapData['firstName'];
    this.lastName = mapData['lastName'];
    this.email = mapData['email'];
    this.userType = mapData['userType'];
    this.profilePhoto = mapData['profilePhoto'];
    this.referralCode = mapData['referralCode'];
    this.phoneNumber = mapData['phoneNumber'];
  }
}