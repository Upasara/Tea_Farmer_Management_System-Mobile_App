import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class UserModel extends DBModel {
  String? name;
  String email;
  String? profileImage;
  String? address;
  String? collector;
  String? tel;
  String registerNumber;
  String status;

  UserModel({
    DocumentReference? ref,
    this.name,
    required this.email,
    required this.registerNumber,
    required this.status,
    this.profileImage,
    this.address,
    this.tel,
    this.collector,
  }) : super(ref: ref);

  @override
  UserModel clone() {
    return UserModel(
      ref: ref,
      name: name,
      email: email,
      profileImage: profileImage,
      registerNumber: registerNumber,
      address: address,
      tel: tel,
      collector: collector,
      status: status,
    );
  }
}
