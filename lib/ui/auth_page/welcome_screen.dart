import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';
import 'package:tefmasys_mobile/ui/auth_page/login_view/login_provider.dart';
import 'package:tefmasys_mobile/ui/auth_page/signup_view/signup_provider.dart';
import 'package:tefmasys_mobile/ui/widgets/context_extension.dart';
import 'package:tefmasys_mobile/ui/widgets/round_button.dart';


class WelcomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ///welcome page view
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height:32),

              const SizedBox(height:32),
              Image.asset(
                "assets/images/5.png",
                height: size.height * 0.45,
              ),

              const Text(
                "TeFMaSys",
                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 40),
              ),const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "ABC Tea company provided application for local farmers",
                  style: TextStyle(fontWeight: FontWeight.w200,fontSize: 20,color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 52),
              SizedBox(
                height: context.dynamicHeight(0.08),
                width: context.dynamicWidth(0.8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginProvider();
                        },
                      ),
                    );
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
              const SizedBox(height: 6),
              SizedBox(
                height: context.dynamicHeight(0.08),
                width: context.dynamicWidth(0.8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpProvider();
                        },
                      ),
                    );
                  },
                  child: Card(
                    color: StyledColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        "Sign Up",
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
            ],
          ),
        ),
      ),
    );
  }
}
