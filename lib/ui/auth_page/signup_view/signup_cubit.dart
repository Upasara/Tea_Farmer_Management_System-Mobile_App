import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tefmasys_mobile/db/authentication.dart';
import 'package:tefmasys_mobile/db/model/user.dart';
import 'package:tefmasys_mobile/ui/auth_page/signup_view/signup_state.dart';

import '../../../db/repository/user_repository.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(BuildContext context) : super(SignUpState.initialState);

  final auth = Authentication();
  final userRepo = UserRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  Future<void> createUser(
    String email,
    String name,
    String address,
    String tel,
    String regNumber,
    String confirmPassword,
    String collector,
  ) async {
    if (email.isEmpty) {
      errorEvent("Email can`t be Empty");
      emit(state.clone(processing: false));
      return;
    }



    if (!isValidEmail(email)) {
      errorEvent("Please Enter valid Email");
      emit(state.clone(processing: false));
      return;
    }

    if (tel.isEmpty) {
      errorEvent("Mobile number can`t be Empty");
      emit(state.clone(processing: false));
      return;
    }

    final fetchEmail =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    if (fetchEmail.isNotEmpty) {
      errorEvent("Email is already exist");
      emit(state.clone(processing: false));
      return;
    }

    if (confirmPassword.length < 6 || confirmPassword.isEmpty) {
      errorEvent("Password must have minimum 6 characters");
      emit(state.clone(processing: false));
      return;
    }

    try {
      final formatter = DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(DateTime.now());

      final userData = await userRepo.querySingle(
          specification:
              ComplexSpecification([ComplexWhere('tel', isEqualTo: tel)]));

      if (userData.isEmpty) {
        errorEvent("No Registered user found for given mobile number");
        emit(state.clone(processing: false));
        return;
      }


      if (userData.isNotEmpty) {
        final user = userData.first;


        final registerNum=user.registerNumber;

        if(registerNum.isEmpty){
          errorEvent("No Registered user found for given mobile number");
          emit(state.clone(processing: false));
          return;
        }

        if(user.status!='pending'){
          errorEvent("User already registered");
          emit(state.clone(processing: false));
          return;
        }

        final register = await auth.register(email, confirmPassword);

        if(register!.isEmpty){
          errorEvent("Something Went wrong");
          emit(state.clone(processing: false));
          return;
        }

        if(registerNum==regNumber){
          await userRepo.update(
            item: user,
            mapper: (_) => {
              'status': 'completed',
              'name': name,
              'address': address,
              'collector': collector,
              'email': email,
            },
          );

          emit(state.clone(email: email, registered: true, processing: false));
        }else{
          errorEvent("Wrong Registration Number");
          emit(state.clone(processing: false));
          return;
        }


      }
    } catch (e) {
      emit(state.clone(email: '', registered: false, processing: false));
      return;
    }
  }

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
