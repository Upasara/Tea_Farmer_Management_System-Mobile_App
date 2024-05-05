import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';
import 'package:tefmasys_mobile/ui/complain_page/complain_cubit.dart';
import 'package:tefmasys_mobile/ui/complain_page/complain_state.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';
import 'package:tefmasys_mobile/ui/root_page/root_state.dart';
import 'package:tefmasys_mobile/ui/widgets/common_snack_bar.dart';
import 'package:tefmasys_mobile/util/size_config.dart';

class ComplainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComplainViewState();
}

class ComplainViewState extends State<ComplainView> {
  static final loadingWidget = const Center(
    child: CircularProgressIndicator(),
  );

  late FocusNode _viewFocus;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewFocus = FocusNode();
  }

  @override
  void dispose() {
    // _viewFocus.dispose();

    super.dispose();
  }

  final _pulseRateController = TextEditingController();
  final _pressure1Controller = TextEditingController();
  final _pressure2Controller = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final separator = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 1.2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            StyledColors.primaryColorDark.withOpacity(0.1),
            StyledColors.primaryColor.withOpacity(0.3)
          ],
        ),
      ),
    );
    final complainCubit = BlocProvider.of<ComplainCubit>(context);

    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Complains",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_viewFocus),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  contentPadding: const EdgeInsets.all(8),
                  filled: true,
                  // border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  fillColor:
                      StyledColors.textFieldsPrimaryLight.withOpacity(0.5),
                  hintText: 'Mention your issue briefly',
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                // <-- SEE HERE
                maxLines: 6,
                controller: _pressure2Controller,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: StyledColors.primaryColor)),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(_viewFocus);
                    complainCubit.addComplain(_pressure2Controller.text);
                    _pressure2Controller.clear();
                  },
                  padding: const EdgeInsets.all(10.0),
                  color: StyledColors.primaryColor,
                  textColor: Colors.white,
                  child: const Text("Submit", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              separator,
              const SizedBox(
                height: 18,
              ),
              BlocBuilder<RootCubit, RootState>(
                  buildWhen: (previous, current) =>
                      previous.allComplains != current.allComplains,
                  builder: (context, state) {
                    if (state.allComplains == null) {
                      return loadingWidget;
                    }

                    List<Widget> children = [];

                    if (state.allComplains!.isEmpty) {
                      children.add(
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 32,
                            horizontal: 1,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'No Complains you have created...',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }

                    for (int i = 0; i < state.allComplains!.length; i++) {
                      final post = state.allComplains![i];

                      final card = Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color:StyledColors.primaryColorDark, width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        // margin: const EdgeInsets.all(16),
                        elevation: 0,
                        color: StyledColors.cardColor.withOpacity(0.3),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Complain :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: StyledColors.primaryColorDark,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Text(
                                        post.complain,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Reply :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: StyledColors.primaryColorDark,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        post.reply!.isEmpty
                                            ? ' - no reply -'
                                            : post.reply ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    post.reply!.isEmpty
                                        ? complainCubit.archiveComplain(post)
                                        : null;
                                  },
                                  icon:  Icon(
                                    Icons.delete,
                                    color: post.reply!.isEmpty?Colors.red:Colors.grey,
                                  ))
                            ],
                          ),
                        ),
                      );

                      children.add(card);
                    }

                    return Expanded(
                        child: ListView(
                      children: children,
                    ));
                  })
            ],
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<ComplainCubit, ComplainState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.showErrorSnackBar(state.error));
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
        BlocListener<ComplainCubit, ComplainState>(
          listenWhen: (pre, current) => pre.state != current.state,
          listener: (context, state) {
            if (state.state == ComplainState.PROCESSING) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.loadingSnackBar);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
