import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enitproject/const/const.dart';

class UserPrefModel {
  String? email;
  String? nickname;
  String? password;

  UserPrefModel(this.email, this.password, this.nickname);
}
