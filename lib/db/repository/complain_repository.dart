import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:tefmasys_mobile/db/model/complain.dart';
import 'package:tefmasys_mobile/util/db_util.dart';


class ComplainRepository extends FirebaseRepository<Complain> {
  ComplainRepository() : super();

  @override
  Complain fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return Complain(
      ref: snapshot.reference,
      complain: data['complain'] ?? '',
      createdAt: data['createdAt'],
      relatedCompany: data['relatedCompany'],
      createdBy: data['createdBy'],
      reply: data['reply']?? ''
    );
  }


  @override
  Stream<List<Complain>> query(
      {required SpecificationI specification,
        String? type,
        DocumentReference? parent}) {
    return super.query(
      specification: specification,
      type: DBUtil.COMPLAINS,
    );
  }


  @override
  Map<String, dynamic> toMap(Complain value) {
    return {
      'complain':value.complain,
      'createdAt':value.createdAt,
      'createdBy':value.createdBy,
      'relatedCompany':value.relatedCompany,
      'reply':value.reply ?? '',
    };
  }

  @override
  Future<DocumentReference> update({
    required Complain item,
    SetOptions? setOptions,
    String? type,
    DocumentReference? parent,
    MapperCallback<Complain>? mapper,
  }) {
    return super.update(
      item: item,
      mapper: mapper,
      type: DBUtil.COMPLAINS,
    );
  }

  @override
  Future<DocumentReference> add({
    required Complain item,
    SetOptions? setOptions,
    DocumentReference? parent,
    String? type,
  }) {
    return super.add(
      item: item,
      type: DBUtil.COMPLAINS,
    );
  }

  @override
  Future<List<Complain>> querySingle(
      {required SpecificationI specification,
        String? type,
        DocumentReference? parent}) {
    return super.querySingle(
      specification: specification,
      type: DBUtil.COMPLAINS,
    );
  }
}
