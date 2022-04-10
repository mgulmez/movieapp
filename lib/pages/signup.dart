import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/blocs/account_bloc.dart';
import 'package:movieapp/extensions.dart';

import '../common/bloc_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool loading = false;
  TextEditingController displayNameController =
      TextEditingController(text: 'Mustafa Gülmez');
  TextEditingController emailController =
      TextEditingController(text: 'mustafa@mustafagulmez.com.tr');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up".tr)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: form(context),
            )
          ],
        ),
      ),
    );
  }

  Widget form(BuildContext context) => BlocListener(
      bloc: context.accountBLOC,
      listener: (ctx, state) {
        setState(() {
          loading = state is LoadingState;
        });
        if (state is ErrorState) {
          ctx.showSnackbar(state.errorMessage);
        } else if (state is UserRegisteredState) {
          ctx.showSnackbar("User successfully registered".tr);
          context.back();
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: displayNameController,
              validator: (value) => value.validateText(
                  errorMessage: 'Name and Surname is required'.tr),
              decoration: InputDecoration(
                labelText: "NAME SURNAME".tr,
              ),
            ),
            TextFormField(
              controller: emailController,
              validator: (value) =>
                  value.validateText(errorMessage: 'Email is required'.tr),
              decoration: InputDecoration(
                labelText: "EMAIL".tr,
              ),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (value) =>
                  value.validateText(errorMessage: 'Password is required'.tr),
              decoration:
                  InputDecoration(labelText: "PASSWORD".tr, hintText: '*****'),
            ),
            ElevatedButton(
                onPressed: loading ? null : () => signup(context),
                child: Text("SIGN UP".tr,
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.white))),
            Container(
              height: 16,
            ),
            Column(
              children: [
                Text("Already have an account?".tr),
                ElevatedButton(
                  onPressed: loading ? null : () => context.back(),
                  child: Text("LOGIN".tr,
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.white)),
                ),
              ],
            ).space(16),
          ],
        ).space(24),
      ));

  void signup(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.accountBLOC.add(RegisterEvent(displayNameController.text,
          emailController.text, passwordController.text));
    }
  }
}
