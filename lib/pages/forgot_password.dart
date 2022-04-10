import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/blocs/account_bloc.dart';
import 'package:movieapp/extensions.dart';
import '../common/app_state.dart';
import '../common/bloc_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends AppState<ForgotPasswordPage> {
  TextEditingController emailController =
      TextEditingController(text: 'mustafa@mustafagulmez.com.tr');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot Password?".tr,
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
        } else if (state is PasswordResetCodeSentState) {
          ctx.back();
          ctx.showSnackbar('Please check your email'.tr);
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
              height: 32,
            ),
            ElevatedButton(
                onPressed: () => forgotPassword(context),
                child: Text("Send Code".tr,
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.white))),
          ],
        ),
      ));

  void forgotPassword(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.accountBLOC.add(ForgotPasswordEvent(emailController.text));
    }
  }
}
