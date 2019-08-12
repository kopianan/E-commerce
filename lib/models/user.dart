import 'package:equatable/equatable.dart';

class User extends Equatable{
   String userId = "";
   String userName = "";
   String email= "";
   String phone= "";
   String fullName= "";
   String birthDate= "";
   String address= "";
   int error = 0 ; 

  User({
    this.userId,
    this.userName,
    this.email,
    this.phone,
    this.fullName,
    this.birthDate,
    this.address,
     this.error
  }) : super([userId,userName,email,phone,fullName,birthDate,address, error]);

   User.fromJson(Map<String, dynamic> json) {
    this.userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    fullName = json['fullName'];
    birthDate = json['birthDate'];
    address = json['address'];
    error = json['error'];
  }

  User.fromJsonError(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() =><String,dynamic>{
    'userId' : userId,
    'userName' : userName,
    'email' : email,
    'fullName' : fullName,
    'birthDate' : birthDate,
    'address' : address,
    'error' : error
  };

}