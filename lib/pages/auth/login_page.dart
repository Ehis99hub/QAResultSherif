import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roavapp/components/fragments/buttons/app_button.dart';
import 'package:roavapp/components/fragments/buttons/app_flat_button.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/services/auth_service.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/snacks.dart';
import 'package:roavapp/values/images.dart';
import 'package:roavapp/values/regex.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController telephone;
  TextEditingController password;
  ValueNotifier<bool> _showPass;
  GlobalKey<FormState> _form = GlobalKey();
  final service = AuthService();

  @override
  void initState() {
    super.initState();
    _showPass = ValueNotifier(false);
    telephone = TextEditingController();
    password = TextEditingController();
  }

  _logIn(BuildContext context) {
    if (_form.currentState.validate()) {
      final data = service.login(
        telephone.text,
        password.text,
      );
      if (data.isSuccessful) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/dashboard",
          (route) => false,
        );
      } else {
        showSnack(
          context: context,
          message: data.message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);

    return Scaffold(
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: Container(
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  padding: scaler.insets.symmetric(
                    vertical: 2,
                    horizontal: 7,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const AppSizedBox(height: 4),
                      AppSizedBox(
                        height: 30,
                        child: SvgPicture.asset(
                          AppSvgs.loginHeader,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const AppSizedBox(height: 4),
                      AppText(
                        "Welcome to\nGreen medical clinic",
                        style: boldText.copyWith(
                          fontSize: 70,
                        ),
                      ),
                      const AppSizedBox(height: 4),
                      AppText(
                        "You can be connected to us and track your healing process with this app.",
                        style: normalText.copyWith(fontSize: 40),
                      ),
                      const AppSizedBox(height: 4),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Phone number"),
                        controller: telephone,
                        key: ValueKey('telephone'),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "This field is required";
                          }
                          if (!phoneRegex.hasMatch(text)) {
                            return "Sorry the provided phone number is invalid";
                          }
                          return null;
                        },
                      ),
                      const AppSizedBox(height: 1.5),
                      ValueListenableBuilder(
                        valueListenable: _showPass,
                        builder: (context, bool val, _) {
                          return TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: InkWell(
                                onTap: () {
                                  _showPass.value = !val;
                                },
                                child: Icon(
                                  !val
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: appBlack.withOpacity(.5),
                                ),
                              ),
                            ),
                            obscureText: !val,
                            controller: password,
                            key: ValueKey('password'),
                            keyboardType: TextInputType.visiblePassword,
                          );
                        },
                      ),
                      const AppSizedBox(height: 4),
                      AppButton(
                        text: "Login",
                        onPressed: () {
                          _logIn(context);
                        },
                        isBold: true,
                      ),
                      const AppSizedBox(height: 1),
                      AppFlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/signup");
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: "Signup",
                                style: boldText.copyWith(
                                    fontSize: scaler.fontSizer.sp(35)),
                              ),
                            ],
                            style: normalText.copyWith(
                                color: appBlack,
                                fontSize: scaler.fontSizer.sp(35)),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
