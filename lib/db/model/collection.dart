import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Collection extends DBModel {
  int teaAmount;
  int monthlyFee;
  int total;
  Timestamp createdAt;

  Collection({
    DocumentReference? ref,
    required this.teaAmount,
    required this.createdAt,
    required this.monthlyFee,
    required this.total,
  }) : super(ref: ref);

  @override
  Collection clone() {
    return Collection(
      ref: ref,
      createdAt: createdAt,
      teaAmount: teaAmount,
      monthlyFee: monthlyFee,
      total: total,
    );
  }
}
