import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Company extends DBModel {
  String? name;
  String email;
  String? address;
  String? tel;

  Company({
    DocumentReference? ref,
    this.name,
    required this.email,
    this.address,
    this.tel,
  }) : super(ref: ref);

  @override
  Company clone() {
    return Company(
      ref: ref,
      name: name,
      email: email,
      address: address,
      tel: tel,
    );
  }
}
