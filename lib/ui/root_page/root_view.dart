
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';

import '../../util/routes.dart';


class RootView extends StatelessWidget {
  final String? email;
  final bool fromSignUp;

  const RootView({
    Key? key,
    this.email,
    this.fromSignUp = false,
  }) : super(key: key);

  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);

    const scaffold = Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (email == null) {
      Future.microtask(
            () => Navigator.pushReplacementNamed(context, Routes.WELCOME_ROUTE),
      );
    }

    if (email != null && !rootCubit.state.userLogged) {
      rootCubit.handleUserLogged(email!);
    }

    if (email != null) {
      Future.microtask(
              () => Navigator.pushReplacementNamed(context, Routes.HOME_ROUTE));
    }

    // if (email == null) {
    //   Future.microtask(
    //           () => Navigator.pushReplacementNamed(context, Routes.HOME_ROUTE));
    // }

    return scaffold;
  }
}
