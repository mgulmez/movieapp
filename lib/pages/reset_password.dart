import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/blocs/account_bloc.dart';
import 'package:movieapp/extensions.dart';

import '../common/app_state.dart';
import '../common/bloc_state.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends AppState<ResetPasswordPage> {
  TextEditingController codeController = TextEditingController(text: '');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Confirm Code".tr,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: form(context),
            ),
          ),
        ),
      );

  Widget form(BuildContext context) => BlocListener(
      bloc: context.accountBLOC,
      listener: (ctx, state) {
        if (state is ErrorState) {
          ctx.showSnackbar(state.errorMessage);
        } else if (state is PasswordChangedState) {
          context.showSnackbar(
              'Your password is successfully changed. Please login with new password');
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
              controller: codeController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  value.validateText(errorMessage: 'Code is required'.tr),
              decoration: InputDecoration(
                  labelText: "CODE".tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (value) =>
                  value.validateText(errorMessage: 'Password is required'.tr),
              decoration: InputDecoration(
                  labelText: "PASSWORD".tr,
                  floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
            Container(
              height: 32,
            ),
            ElevatedButton(
                onPressed: () => resetPassword(context),
                child: Text("Change Password".tr,
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.white))),
          ],
        ),
      ));

  void resetPassword(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.accountBLOC.add(
          ResetPasswordEvent(codeController.text, passwordController.text));
    }
  }
}
