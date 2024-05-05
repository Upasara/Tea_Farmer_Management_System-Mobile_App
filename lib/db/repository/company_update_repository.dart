import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:tefmasys_mobile/db/model/company_update.dart';
import 'package:tefmasys_mobile/db/model/complain.dart';
import 'package:tefmasys_mobile/util/db_util.dart';

class CompanyUpdatesRepository extends FirebaseRepository<CompanyUpdate> {
  CompanyUpdatesRepository() : super();

  @override
  CompanyUpdate fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return CompanyUpdate(
      ref: snapshot.reference,
      createdAt: data['createdAt'],
      createdBy: data['createdBy'],
      content: data['content'] ?? '',
      title: data['title'] ?? '',
      type: data['type'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap(CompanyUpdate value) {
    return {
      'content': value.content,
      'createdAt': value.createdAt,
      'createdBy': value.createdBy,
      'title': value.title,
      'type': value.type,
    };
  }

  @override
  Stream<List<CompanyUpdate>> query(
      {required SpecificationI specification,
      String? type,
      DocumentReference? parent}) {
    return super.query(
      specification: specification,
      type: DBUtil.COMPANY_UPDATES,
    );
  }

  @override
  Future<DocumentReference> update({
    required CompanyUpdate item,
    SetOptions? setOptions,
    String? type,
    DocumentReference? parent,
    MapperCallback<CompanyUpdate>? mapper,
  }) {
    return super.update(
      item: item,
      mapper: mapper,
      type: DBUtil.COMPANY_UPDATES,
    );
  }

  @override
  Future<DocumentReference> add({
    required CompanyUpdate item,
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
  Future<List<CompanyUpdate>> querySingle(
      {required SpecificationI specification,
      String? type,
      DocumentReference? parent}) {
    return super.querySingle(
      specification: specification,
      type: DBUtil.USER,
    );
  }
}
