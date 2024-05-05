import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tefmasys_mobile/ui/auth_page/login_view/login_cubit.dart';
import 'package:tefmasys_mobile/ui/auth_page/login_view/login_state.dart';
import 'package:tefmasys_mobile/ui/auth_page/signup_view/signup_provider.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';
import 'package:tefmasys_mobile/ui/root_page/root_view.dart';
import 'package:tefmasys_mobile/ui/widgets/common_snack_bar.dart';
import 'package:tefmasys_mobile/ui/widgets/context_extension.dart';

import '../../../theme/styled_colors.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/reusable_widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  late FocusNode _viewFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _viewFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _viewFocus.dispose();
    _emailFocus.dispose();
    _emailController.dispose();
    _passwordFocus.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginBloc = BlocProvider.of<LoginCubit>(context);
    final rootBloc = BlocProvider.of<RootCubit>(context);

    void _loginClicked() {
      ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.loadingSnackBar);

      final email = (_emailController.text).trim();
      final password = (_passwordController.text).trim();
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
            AppSnackBar.showErrorSnackBar("Email or Password is Empty!"));

        return;
      }

      loginBloc.userLogin(email, password);
    }

    final scaffold = Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_viewFocus),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.35),
                  child: ReusableWidgets.getImageAsset(
                      "undraw_Unlock_re_a558.png"),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: StyledColors.primaryColor,
                  onSaved: (email) {},
                  decoration: const InputDecoration(
                    hintText: "Your Email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    cursorColor: StyledColors.primaryColor,
                    decoration: const InputDecoration(
                      hintText: "Your password",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: context.dynamicHeight(0.09),
                  width: context.dynamicWidth(0.8),
                  child: InkWell(
                    onTap: () {
                      _loginClicked();
                    },
                    child: Card(
                      color: StyledColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                AlreadyHaveAnAccountCheck(
                  login: true,
                  press: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
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
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (pre, current) => pre.processing != current.processing,
          listener: (context, state) {
            if (state.processing) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.loadingSnackBar);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (pre, current) =>
              pre.email != current.email && current.email.isNotEmpty,
          listener: (context, state) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();

            rootBloc.handleUserLogged(state.email);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RootView(
                  email: state.email,
                ),
              ),
            );
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => true,
        child: scaffold,
      ),
    );
  }
}
