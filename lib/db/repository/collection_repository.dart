import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:tefmasys_mobile/db/model/collection.dart';
import 'package:tefmasys_mobile/db/model/notification.dart';
import 'package:tefmasys_mobile/util/db_util.dart';

class CollectionRepository extends FirebaseRepository<Collection> {
  @override
  Collection fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();
    return Collection(
      ref: snapshot.reference,
      createdAt: data[Notification.CREATED_AT],
      total: data['total'] ?? 0,
      monthlyFee: data['monthlyFee'] ?? 0,
      teaAmount: data['teaAmount'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap(Collection item) {
    return {
      'createdAt': item.createdAt,
      'total': item.total,
      "monthlyFee": item.monthlyFee,
      'teaAmount': item.teaAmount,
    };
  }

  @override
  Stream<List<Collection>> query({
    required SpecificationI specification,
    String? type,
    required DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.TEA,
      parent: parent,
    );
  }

  @override
  Future<DocumentReference> add({
    required Collection item,
    String? type,
    DocumentReference? parent,
  }) {
    return super.add(
      item: item,
      type: DBUtil.TEA,
    );
  }
}
