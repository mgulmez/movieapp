import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:movieapp/blocs/account_bloc.dart';
import 'package:movieapp/blocs/favorites_bloc.dart';
import 'package:movieapp/blocs/theme.dart';

import 'blocs/movie_bloc.dart';

extension ComparableExtensions on Comparable? {
  bool get hasValue => this != null;
}

extension StringExtensions on String {
  String get tr => i18n();
  String trArgs(List<String> arguments) {
    return i18n(arguments);
  }

  bool get isValidPhone {
    return RegExp(r'^(?:[+0]9)[0-9]{10,12}$').hasMatch(this);
  }

  bool get isEmail {
    return RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
        .hasMatch(this);
  }

  String get toFixedPhoneNumber {
    var fixedValue = this;
    if (!fixedValue.startsWith('+')) {
      if (!fixedValue.startsWith('0')) fixedValue = '0' + fixedValue;
      if (!fixedValue.startsWith('9')) fixedValue = '9' + fixedValue;
      fixedValue = '+' + fixedValue;
    }
    return fixedValue;
  }
}

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  NavigatorState get navigator => Navigator.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  Future<T?> toNamed<T extends Object?>(String routeName) {
    return navigator.pushNamed<T>(routeName);
  }

  Future popAndToNamed(String routeName) {
    return navigator.popAndPushNamed(routeName);
  }

  Future<T?> replaceTo<T extends Object?>(Widget child, {Bloc? bloc}) {
    back();
    return push(child, bloc: bloc);
  }

  void back<T extends Object?>([T? result]) {
    return navigator.pop(result);
  }

  Future bottomSheet<T extends Object?>(Widget child,
      {bool? isDismissible}) async {
    showModalBottomSheet<T>(
        context: this,
        backgroundColor: Colors.black12,
        builder: (BuildContext context) {
          return child;
        });
  }

  Future<T?> showAlertDialog<T extends Object?>(
      String title, String message, List<Widget> buttons) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: buttons,
    );
    return showDialog<T>(
        context: this,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Future<T?> push<T extends Object?>(Widget child, {Bloc? bloc}) {
    return navigator.push<T>(
      MaterialPageRoute(
        builder: (context) => bloc != null
            ? BlocProvider.value(
                value: bloc,
                child: child,
              )
            : child,
      ),
    );
  }

  MovieBLOC get movieBLOC => BlocProvider.of<MovieBLOC>(this);
  ThemeBLOC get themeBLOC => BlocProvider.of<ThemeBLOC>(this);
  AccountBLOC get accountBLOC => BlocProvider.of<AccountBLOC>(this);
  FavoritesBLOC get favoritesBLOC => BlocProvider.of<FavoritesBLOC>(this);
  void showSnackbar(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
}

extension ColumnExtensions on Column {
  Column separated(Widget Function(int) separatorBuilder) {
    var children = this.children;
    var l = children.length;
    for (var i = 0; i < l; i++) {
      if (i < l - 1) {
        this.children.insert(2 * i + 1, separatorBuilder(i));
      }
    }

    return this;
  }

  Column space(double spacing) {
    var t = this;
    return t.separated((i) => Container(
          height: spacing,
        ));
  }
}

extension RowExtensions on Row {
  Row separated(Widget Function(int) separatorBuilder) {
    var children = this.children;
    var l = children.length;

    for (var i = 0; i < l; i++) {
      if (i < l - 1) this.children.insert(2 * i + 1, separatorBuilder(i));
    }

    return this;
  }

  Row space(double spacing) {
    var t = this;
    return t.separated((i) => Container(
          width: spacing,
        ));
  }
}

extension NullableStringExtensions on String? {
  String get clearedText => this != null
      ? this!.replaceAll(',', '').replaceAll(' ', '').replaceAll(';', '')
      : '';
  bool get isNotEmpty => this != null && this!.isNotEmpty;
  bool get isEmpty {
    var t = this;
    return !t.isNotEmpty;
  }

  String get firstSentence {
    if (this == null || this!.isEmpty) return '';
    return this!.split('.')[0];
  }

  String? validatePhone([bool required = true]) {
    var value = this;
    return required &&
            (value == null || !value.replaceAll(' ', '').isValidPhone)
        ? 'Please enter a valid phone'.tr
        : null;
  }

  String? validateEmail([bool required = true]) {
    var value = this;
    return required && (value == null || !value.isEmail)
        ? 'Please enter a valid email'.tr
        : null;
  }

  String? validateText(
      {bool required = true, String? errorMessage, int? minLength}) {
    var value = this;
    return required && (value == null || value.isEmpty)
        ? errorMessage ?? 'This field is required'.tr
        : minLength.hasValue && value.clearedText.length < minLength!
            ? "You have to type more characters".tr
            : null;
  }

  String? validatePassword({bool required = true, String? errorMessage}) {
    var value = this;
    return required && (value == null || value.isEmpty)
        ? errorMessage ?? 'This field is required'.tr
        : null;
  }

  String? validatePrice([bool required = true]) {
    var value = this;
    return required && (value == null || value.isEmpty)
        ? 'This field is required'.tr
        : null;
  }
}
