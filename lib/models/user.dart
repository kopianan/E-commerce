import 'package:equatable/equatable.dart';

class User extends Equatable{
   String userId;
   String userName;
   String email;
   String phone;
   String fullName;
   String birthDate;
   String address;

  User({
    this.userId,
    this.userName,
    this.email,
    this.phone,
    this.fullName,
    this.birthDate,
    this.address
  }) : super([userId,userName,email,phone,fullName,birthDate,address]);

   User.fromJson(Map<String, dynamic> json) {
    this.userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    fullName = json['fullName'];
    birthDate = json['birthDate'];
    address = json['address'];
  }

}