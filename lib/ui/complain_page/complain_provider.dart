
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tefmasys_mobile/ui/complain_page/complain_cubit.dart';
import 'package:tefmasys_mobile/ui/complain_page/complain_view.dart';

class ComplainProvider extends BlocProvider<ComplainCubit> {
  ComplainProvider({
    Key? key,
  }) : super(
    key: key,
    create: (context) => ComplainCubit(context),
    child:  ComplainView(),
  );
}
