import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:tefmasys_mobile/util/db_util.dart';

import '../model/user.dart';

class UserRepository extends FirebaseRepository<UserModel> {
  UserRepository() : super();

  @override
  UserModel fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return UserModel(
      ref: snapshot.reference,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      profileImage: data['profileImage'] ?? '',
      registerNumber: data['registrationNumber'] ?? '',
      tel: data['tel'] ?? '',
      address: data['address'] ?? '',
      collector: data['collector'] ?? '',
      status: data['status'] ?? 'pending'
    );
  }

  @override
  Map<String, dynamic> toMap(UserModel value) {
    return {
      'email': value.email,
      'name': value.name ?? '',
      'profileImage': value.profileImage ?? '',
      'address': value.address ?? '',
      'tel': value.tel ?? "",
      'registrationNumber': value.registerNumber,
      'collector': value.collector,
      'status':value.status,
    };
  }

  @override
  Future<DocumentReference> update({
     UserModel? item,
    SetOptions? setOptions,
    String? type,
    DocumentReference? parent,
    MapperCallback<UserModel>? mapper,
  }) {
    return super.update(
      item: item,
      mapper: mapper,
      type: DBUtil.USER,
    );
  }

  @override
  Future<DocumentReference> add({
    required UserModel item,
    SetOptions? setOptions,
    DocumentReference? parent,
    String? type,
  }) {
    return super.add(
      item: item,
      type: DBUtil.USER,
    );
  }

  @override
  Future<List<UserModel>> querySingle({required SpecificationI specification,
    String? type,
    DocumentReference? parent}) {
    return super.querySingle(
      specification: specification,
      type: DBUtil.USER,
    );
  }
}
