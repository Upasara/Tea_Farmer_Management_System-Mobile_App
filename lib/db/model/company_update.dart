import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class CompanyUpdate extends DBModel {
  String? title;
  String? content;
  DocumentReference createdBy;
  Timestamp createdAt;
  int type;

  CompanyUpdate({
    DocumentReference? ref,
    this.title,
    this.content,
    required this.createdAt,
    required this.createdBy,
    required this.type,
  }) : super(ref: ref);

  @override
  CompanyUpdate clone() {
    return CompanyUpdate(
      ref: ref,
      createdAt: createdAt,
      createdBy: createdBy,
      title: title,
      content: content,
      type: type,
    );
  }
}
