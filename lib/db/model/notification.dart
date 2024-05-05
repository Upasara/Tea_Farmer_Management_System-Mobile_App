import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Notification extends DBModel {
  static const TITLE = 'title';
  static const CREATED_AT = 'createdAt';
  static const CREATED_BY = 'createdBy';
  static const TARGET_USER = 'targetUser';
  static const TYPE = 'type';

  static const ALL='all';
  static const ONLY_USER='onlyUser';

  static const LIKE='like';
  static const DISLIKE='dislike';
  static const COMMENT='comment';
  static const SYSTEM='system';


  String title;
  Timestamp createdAt;
  DocumentReference? createdBy;

  Notification({
    DocumentReference? ref,
    required this.title,
    required this.createdAt,
    this.createdBy,
  }) : super(ref: ref);

  @override
  Notification clone({
    DocumentReference? ref,
    String? title,
    Timestamp? createdAt,
    DocumentReference? createdBy,
  }) {
    return Notification(
      ref: ref ?? this.ref,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
