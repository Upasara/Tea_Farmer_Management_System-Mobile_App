import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Complain extends DBModel {
  String complain;
  String? reply;
  String? user;
  DocumentReference? createdBy;
  Timestamp createdAt;
  DocumentReference? relatedCompany;

  Complain({
    DocumentReference? ref,
    required this.complain,
    this.reply,
    required this.createdAt,
    this.createdBy,
    this.relatedCompany,
    this.user,
  }) : super(ref: ref);

  @override
  Complain clone() {
    return Complain(
      ref: ref,
      createdAt: createdAt,
      createdBy: createdBy,
      relatedCompany: relatedCompany,
      complain: complain,
      reply: reply,
      user: user,
    );
  }
}
