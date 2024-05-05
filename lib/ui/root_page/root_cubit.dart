import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tefmasys_mobile/db/authentication.dart';
import 'package:tefmasys_mobile/db/model/user.dart';
import 'package:tefmasys_mobile/db/repository/collection_repository.dart';
import 'package:tefmasys_mobile/db/repository/company_update_repository.dart';
import 'package:tefmasys_mobile/db/repository/complain_repository.dart';
import 'package:tefmasys_mobile/db/repository/user_repository.dart';
import 'package:tefmasys_mobile/ui/root_page/root_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as fireStorage;

class RootCubit extends Cubit<RootState> {
  RootCubit(BuildContext context) : super(RootState.initialState);


  final _userRepository = UserRepository();
  final _complainRepository = ComplainRepository();
  final _companyUpdatesRepository = CompanyUpdatesRepository();
  final _teaRepository = CollectionRepository();
  final auth = Authentication();

  void initialize() async {
    if (state.initialized) {
      return;
    }
    await Firebase.initializeApp();
    emit(state.clone(initialized: true));
  }

  void _getUsersByEmail(final String email) {
    _userRepository
        .query(
            specification:
                ComplexSpecification([ComplexWhere('email', isEqualTo: email)]),
            type: 'Users')
        .listen((users) {
      users.isNotEmpty ? _changeCurrentUser(users.first) : null;
    });
  }

  void handleUserLogged(String email) {
    if (state.userLogged) {
      return;
    }
    emit(state.clone(userLogged: true));
    _getUsersByEmail(email);
  }

  bool isUserAvailable() {
    if (state.currentUser == null) {
      return false;
    }
    return true;
  }

  _changeCurrentUser(UserModel user) {
    emit(state.clone(
      currentUser: user,
    ));
    getAllComplains(user);
    getAllUpdates(user);
    getAllCollections(user);
  }

  Future<void> handleUserLoggedOut() async {
    await auth.logout();
    emit(RootState.initialState);
  }

  getAllComplains(UserModel user) {
    _complainRepository
        .query(
            specification: ComplexSpecification(
                [ComplexWhere('createdBy', isEqualTo: user.ref)]))
        .listen((event) {
      if (event.isNotEmpty) {
        emit(state.clone(allComplains: event));
      } else {
        emit(state.clone(allComplains: []));
      }
    });
  }

  getAllUpdates(UserModel user) {
    _companyUpdatesRepository
        .query(specification: ComplexSpecification([]))
        .listen((event) {
      if (event.isNotEmpty) {
        emit(state.clone(allUpdates: event));
      } else {
        emit(state.clone(allUpdates: []));
      }
    });
  }

  getAllCollections(UserModel user) {
    _teaRepository
        .query(specification: ComplexSpecification([]), parent: user.ref)
        .listen((event) {
      if (event.isNotEmpty) {
        emit(state.clone(teaCollections: event));
      } else {
        emit(state.clone(teaCollections: []));
      }
    });
  }

  updateProfileImage(PickedFile imgFile) async {
    emit(state.clone(isImageAdding: true));

    final image = imgFile.path;

    final fileType = image.split('.').last;

    final storagePath =
        'ProfileImages/${state.currentUser} ${DateTime.now().toString()}.$fileType';

    final storageRef =
        fireStorage.FirebaseStorage.instance.ref().child(storagePath);

    fireStorage.TaskSnapshot uploadTask = await storageRef.putFile(File(image));

    if (uploadTask.state == fireStorage.TaskState.error ||
        uploadTask.state == fireStorage.TaskState.canceled) {
      emit(state.clone(isImageAdding: false));
      return;
    }

    final downloadUrl = await uploadTask.ref.getDownloadURL();

    if (state.currentUser != null) {
      await _userRepository.update(
          item: state.currentUser,
          mapper: (_) => {
                'profileImage': downloadUrl,
              });
    }

    emit(state.clone(isImageAdding: false));
  }
}
