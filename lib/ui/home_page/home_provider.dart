
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tefmasys_mobile/ui/home_page/home_cubit.dart';
import 'package:tefmasys_mobile/ui/home_page/home_view.dart';

class HomeProvider extends BlocProvider<HomeCubit> {
  HomeProvider({
    Key? key,
  }) : super(
    key: key,
    create: (context) => HomeCubit(context),
    child:  const HomeView(),
  );
}
