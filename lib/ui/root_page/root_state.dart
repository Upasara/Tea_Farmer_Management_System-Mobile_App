import 'package:flutter/material.dart';
import 'package:tefmasys_mobile/db/model/collection.dart';
import 'package:tefmasys_mobile/db/model/company_update.dart';
import 'package:tefmasys_mobile/db/model/complain.dart';
import 'package:tefmasys_mobile/db/model/user.dart';

@immutable
class RootState {
  final bool initialized;
  final UserModel? currentUser;
  final bool userLogged;
  final bool isProcessing;
  final bool isImageAdding;
  final List<Complain>? allComplains;
  final List<CompanyUpdate>? allUpdates;
  final List<Collection>? teaCollections;

  const RootState(
      {required this.initialized,
      this.currentUser,
      required this.userLogged,
      required this.isProcessing,
      required this.allComplains,
      required this.allUpdates,
      required this.teaCollections,
      required this.isImageAdding});

  static RootState get initialState => const RootState(
        initialized: false,
        currentUser: null,
        userLogged: false,
        isProcessing: false,
        allComplains: null,
        allUpdates: null,
        teaCollections: null,
        isImageAdding: false,
      );

  RootState clone(
      {bool? initialized,
      UserModel? currentUser,
      bool? userLogged,
      bool? isProcessing,
      bool? isImageAdding,
      List<Complain>? allComplains,
      List<CompanyUpdate>? allUpdates,
      List<Collection>? teaCollections}) {
    return RootState(
      initialized: initialized ?? this.initialized,
      currentUser: currentUser ?? this.currentUser,
      userLogged: userLogged ?? this.userLogged,
      isProcessing: isProcessing ?? this.isProcessing,
      allComplains: allComplains ?? this.allComplains,
      allUpdates: allUpdates ?? this.allUpdates,
      teaCollections: teaCollections ?? this.teaCollections,
      isImageAdding: isImageAdding ?? this.isImageAdding,
    );
  }
}
