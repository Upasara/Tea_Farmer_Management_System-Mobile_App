import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tefmasys_mobile/db/authentication.dart';
import 'package:tefmasys_mobile/db/repository/user_repository.dart';
import 'package:tefmasys_mobile/ui/auth_page/login_view/login_state.dart';
import 'package:tefmasys_mobile/ui/home_page/home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit(BuildContext context) : super(HomeState.initialState);


  @override
  void onError(Object error, StackTrace stackTrace) {
    _addErr(error);
    super.onError(error, stackTrace);
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      errorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      );
    } catch (e) {
      errorEvent("Something went wrong. Please try again !");
    }
  }

  void errorEvent(String error) {
    emit(state.clone(error: ''));
    emit(state.clone(error: error));
  }
}
