import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movieapp/blocs/account_bloc.dart';
import 'package:movieapp/extensions.dart';
import 'package:movieapp/pages/signup.dart';

import '../common/app_state.dart';
import '../common/bloc_state.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends AppState<LoginPage> {
  bool loading = false;
  TextEditingController emailController =
      TextEditingController(text: 'mustafa@mustafagulmez.com.tr');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
                  child: logo(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: form(context),
                )
              ],
            ),
          ),
        ),
      );

  Widget logo(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/icon_logo.svg",
            height: 150,
          ),
          Text(
            "Movie App".tr,
            style: context.theme.textTheme.headline6!.copyWith(
                letterSpacing: 5,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 16),
          )
        ],
      ).space(14);

  Widget form(BuildContext context) => BlocListener(
      bloc: context.accountBLOC,
      listener: (ctx, state) {
        setState(() {
          loading = state is LoadingState;
        });
        if (state is ErrorState) {
          ctx.showSnackbar(state.errorMessage);
        } else if (state is UserLoggedInState) {
          context.popAndToNamed('/movies');
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  value.validateText(errorMessage: 'Email is required'.tr),
              decoration: InputDecoration(
                  labelText: "EMAIL".tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
            Container(
              height: 24,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (value) =>
                  value.validateText(errorMessage: 'Password is required'.tr),
              decoration: InputDecoration(labelText: "PASSWORD".tr),
            ),
            Container(
              height: 32,
            ),
            ElevatedButton(
                onPressed: loading ? null : () => login(context),
                child: Text("LOGIN".tr,
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.white))),
            Container(
              height: 64,
            ),
            Column(
              children: [
                Text(
                  "Don’t have an Account yet?".tr,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () => context.push(const SignupPage(),
                          bloc: context.accountBLOC),
                  child: Text("SIGN UP".tr,
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.white)),
                ),
              ],
            ).space(16),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: GestureDetector(
                onTap: loading
                    ? null
                    : () => context.push(const ForgotPasswordPage()),
                child: Text(
                  "Forgot Password?".tr,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ));

  void login(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.accountBLOC
          .add(LoginEvent(emailController.text, passwordController.text));
    }
  }
}
