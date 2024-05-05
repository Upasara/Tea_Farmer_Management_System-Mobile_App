import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tefmasys_mobile/theme/primary_theme.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';
import 'package:tefmasys_mobile/ui/root_page/root_view.dart';

import '../util/routes.dart';

class AppView extends StatelessWidget {
  final String? email;

  const AppView(
    this.email,
  );

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TEFMASYS",
      theme: PrimaryTheme.generateTheme(context),
      home: RootView(
        email: email,
      ),
      onGenerateRoute: Routes.generator,
    );

    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<RootCubit>(
          create: (context) => RootCubit(context),
          lazy: false,
        ),
      ],
      child: materialApp,
    );
  }
}
