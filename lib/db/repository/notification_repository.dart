import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:tefmasys_mobile/db/model/notification.dart';
import 'package:tefmasys_mobile/util/db_util.dart';


class NotificationRepository extends FirebaseRepository<Notification> {
  @override
  Notification fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();
    return Notification(
      ref: snapshot.reference,
      title: data[Notification.TITLE] ?? "",
      createdAt: data[Notification.CREATED_AT],
      createdBy: data[Notification.CREATED_BY],
    );
  }

  @override
  Map<String, dynamic> toMap(Notification item) {
    return {
      Notification.TITLE: item.title,
      Notification.CREATED_BY: item.createdBy,
      Notification.CREATED_AT: item.createdAt,
    };
  }

  @override
  Stream<List<Notification>> query({
    required SpecificationI specification,
    String? type,
    DocumentReference? parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.NOTIFICATION,
    );
  }

  @override
  Future<DocumentReference> add({
    required Notification item,
    String? type,
    DocumentReference? parent,
  }) {
    return super.add(
      item: item,
      type: DBUtil.NOTIFICATION,
    );
  }
}
