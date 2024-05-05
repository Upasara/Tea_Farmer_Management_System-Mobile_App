import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tefmasys_mobile/db/model/complain.dart';
import 'package:tefmasys_mobile/db/repository/complain_repository.dart';
import 'package:tefmasys_mobile/ui/complain_page/complain_state.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';

class ComplainCubit extends Cubit<ComplainState> {
  ComplainCubit(BuildContext context)
      : rootCubit = BlocProvider.of<RootCubit>(context),
        super(ComplainState.initialState);

  final complainRepo = ComplainRepository();
  final RootCubit rootCubit;

  addComplain(String text) async {
    emit(state.clone(state: ComplainState.PROCESSING));

    if (text.isEmpty) {
      errorEvent('Please enter complain');
      emit(state.clone(state: ComplainState.INITIAL));
      return;
    }
    final complain = Complain(
        complain: text,
        createdAt: Timestamp.now(),
        createdBy: rootCubit.state.currentUser?.ref,
        user: rootCubit.state.currentUser?.name ?? '');

    try {
      await complainRepo.add(item: complain);
      emit(state.clone(state: ComplainState.COMPLETE));
    } catch (e) {
      print(e);
      emit(state.clone(state: ComplainState.INITIAL));
    }
  }

  archiveComplain(Complain complain) async {
    try {
      // emit(state.clone(state: ComplainState.PROCESSING));
      await complainRepo.remove(item: complain);
      // emit(state.clone(state: ComplainState.COMPLETE));
    } catch (e) {
      print(e);
      emit(state.clone(state: ComplainState.INITIAL));
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
