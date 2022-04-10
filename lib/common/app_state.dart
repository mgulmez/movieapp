import 'package:flutter/material.dart';

abstract class AppState<T extends StatefulWidget> extends State<T> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
