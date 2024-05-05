import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tefmasys_mobile/ui/auth_page/signup_view/signup_cubit.dart';
import 'package:tefmasys_mobile/ui/auth_page/signup_view/signup_state.dart';
import 'package:tefmasys_mobile/ui/root_page/root_cubit.dart';
import 'package:tefmasys_mobile/ui/root_page/root_view.dart';
import 'package:tefmasys_mobile/ui/widgets/common_snack_bar.dart';
import 'package:tefmasys_mobile/ui/widgets/context_extension.dart';

import '../../../theme/styled_colors.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/reusable_widgets.dart';
import '../../widgets/social_icon.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _telController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _collectorController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  late FocusNode _viewFocus;
  late FocusNode _emailFocus;
  late FocusNode _nameFocus;
  late FocusNode _passwordFocus;
  late FocusNode _addressFocus;
  late FocusNode _telFocus;
  late FocusNode _registrationNumberFocus;
  late FocusNode _collectorFocus;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _viewFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _addressFocus = FocusNode();
    _telFocus = FocusNode();
    _nameFocus = FocusNode();
    _registrationNumberFocus = FocusNode();
    _collectorFocus = FocusNode();
  }

  @override
  void dispose() {
    _viewFocus.dispose();
    _emailFocus.dispose();
    _emailController.dispose();
    _passwordFocus.dispose();
    _nameController.dispose();
    _nameFocus.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _telController.dispose();
    _registrationNumberController.dispose();
    _addressFocus.dispose();
    _telFocus.dispose();
    _registrationNumberFocus.dispose();
    _collectorFocus.dispose();
    _collectorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);

    final signUpCubit = BlocProvider.of<SignUpCubit>(context);
    final rootBloc = BlocProvider.of<RootCubit>(context);

    void _registerClicked() {
      ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.loadingSnackBar);
      final email = (_emailController.text).trim();
      final name = (_nameController.text).trim();
      final password = (_passwordController.text).trim();
      final address = (_addressController.text).trim();
      final tel = (_telController.text).trim();
      final regNumber = (_registrationNumberController.text).trim();
      final collector = (_collectorController.text).trim();

      signUpCubit.createUser(
          email, name, address, tel,regNumber, password, collector);
    }

    final scaffold = Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_viewFocus),
        child: SingleChildScrollView(
          child: Container(
            height: mediaData.size.height,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                const Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: context.dynamicHeight(0.23),
                  child: ReusableWidgets.getImageAsset("login_5(1).png"),
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
                    hintText: "Email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.email),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  cursorColor: StyledColors.primaryColor,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _addressController,
                  focusNode: _addressFocus,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  cursorColor: StyledColors.primaryColor,
                  decoration: const InputDecoration(
                    hintText: "Address",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _telController,
                  focusNode: _telFocus,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  cursorColor: StyledColors.primaryColor,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Mobile Number",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.phone),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _registrationNumberController,
                  focusNode: _registrationNumberFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  cursorColor: StyledColors.primaryColor,
                  decoration: const InputDecoration(
                    hintText: "Registration Number",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.app_registration),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _collectorController,
                  focusNode: _collectorFocus,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  cursorColor: StyledColors.primaryColor,
                  decoration: const InputDecoration(
                    hintText: "Collector Name",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.shopping_cart),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: StyledColors.primaryColor,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: context.dynamicHeight(0.09),
                  width: context.dynamicWidth(0.8),
                  child: InkWell(
                    onTap: () {
                      _registerClicked();
                    },
                    child: Card(
                      color: StyledColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          "SignUp",
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
                const SizedBox(height: 16),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpCubit, SignUpState>(
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
        BlocListener<SignUpCubit, SignUpState>(
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
        BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (pre, current) =>
              pre.registered != current.registered ||
              pre.email != current.email,
          listener: (context, state) {
            if (state.registered && state.email.isNotEmpty) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();

              rootBloc.handleUserLogged(state.email);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RootView(
                    email: state.email,
                    fromSignUp: true,
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
