import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roavapp/components/fragments/buttons/app_back_button.dart';
import 'package:roavapp/components/fragments/buttons/app_button.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/services/auth_service.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/snacks.dart';
import 'package:roavapp/values/regex.dart';

class SignupPage extends StatefulWidget {
  const SignupPage();

  @override
  State<StatefulWidget> createState() {
    return _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController name;
  TextEditingController telephone;
  TextEditingController password;
  ValueNotifier<bool> _showPass;
  GlobalKey<FormState> _form = GlobalKey();
  final service = AuthService();

  @override
  void initState() {
    super.initState();
    service.isPreviousUser = true;
    _showPass = ValueNotifier(false);
    name = TextEditingController();
    telephone = TextEditingController();
    password = TextEditingController();
  }

  _signUp(BuildContext context) {
    if (_form.currentState.validate()) {
      final data = service.signup(
        name.text,
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
      body: SafeArea(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AppBackButton.plain(),
                      InkWell(
                        child: AppText(
                          "LOGIN",
                          style: normalText.copyWith(
                            color: appTeal,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/login");
                        },
                      ),
                    ],
                  ),
                  const AppSizedBox(height: 4),
                  AppText(
                    "Signup",
                    style: boldText.copyWith(
                      fontSize: 70,
                    ),
                  ),
                  const AppSizedBox(height: 4),
                  AppText(
                    "Please ensure to provide the correct details below",
                    style: normalText.copyWith(fontSize: 40),
                  ),
                  const AppSizedBox(height: 4),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Full name"),
                    controller: name,
                    key: ValueKey('name'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                  ),
                  const AppSizedBox(height: 1.5),
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
                          if (!passRegEx.hasMatch(text)) {
                            return "Sorry the provided password is not strong enough, passwords should have at least one capital letter";
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
                              !val ? Icons.visibility : Icons.visibility_off,
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
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return Container(
            padding: scaler.insets.symmetric(
              horizontal: 7,
            ),
            margin: scaler.insets.only(bottom: 4),
            constraints: BoxConstraints.tightFor(
              height: scaler.fontSizer.sp(140),
            ),
            child: AppButton(
              text: "Signup",
              onPressed: () {
                _signUp(context);
              },
              isBold: true,
            ),
          );
        },
      ),
    );
  }
}
