import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/auth/domain/auth_service.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/screens/movies_screen/movie_screen.dart';

part './widgets/_sign_in_button.dart';

// ---Texts---
const _kTitle = 'Movie';
const _kUsername = 'Username';
const _kPassword = 'Password';
const _kWelcome = 'Welcome';
const _kSignInContinue = 'Sign in to continue!';
const _kWrongUsername = 'Please enter username';
const _kWrongPassword = 'Please enter password';

// ---Parameters---
const _kPadding = 15.0;
const _kTop = 60.0;

const _kFontSizeTwo = 18.0;

class AuthScreen extends StatefulWidget {
  static const _routeName = '/authentication';

  const AuthScreen({Key? key}) : super(key: key);

  static PageRoute<AuthScreen> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return const AuthScreen();
        // return BlocProvider(
        //   create: (context) => MovieAuthentication(),
        //   child: const MovieAuthentication(),
        // );
      },
    );
  }

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? username;
  String? password;
  bool isPasswordVisible = false;
  AuthService get authService => GetIt.instance.get<AuthService>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(_kTitle),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: _kPadding,
              right: _kPadding,
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: _kTop),
                  const WelcomeText(),
                  const SizedBox(height: _kPadding),
                  const SignInText(),
                  const SizedBox(height: _kTop),
                  _UsernameField(
                    onSaved: (value) {
                      username = value;
                    },
                  ),
                  _PasswordField(
                    isVisible: isPasswordVisible,
                    onSaved: (value) {
                      password = value;
                    },
                    onShow: (value) {
                      setState(() {
                        isPasswordVisible = !value;
                      });
                    },
                  ),
                  const SizedBox(height: _kTop),
                  Center(
                    child: SignInButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          authService.postSessionWithLogin(
                              username!, password!);
                          Navigator.push(context, MovieScreen.route);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _kWelcome,
      style: context.theme.textTheme.headline5!.copyWith(
        color: AppColors.darkBlue,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SignInText extends StatelessWidget {
  const SignInText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _kSignInContinue,
      style: context.theme.textTheme.subtitle1!.copyWith(
        color: AppColors.darkBlue,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class _UsernameField extends StatelessWidget {
  final ValueChanged<String?> onSaved;
  const _UsernameField({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      decoration: const InputDecoration(labelText: _kUsername),
      validator: _validate,
    );
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      // пустые инпуты не валидные
      return _kWrongUsername;
    }
    return null;
  }
}

class _PasswordField extends StatelessWidget {
  final ValueChanged<String?> onSaved;
  final bool isVisible;
  final ValueChanged<bool> onShow;

  const _PasswordField({
    Key? key,
    required this.onSaved,
    required this.isVisible,
    required this.onShow,
  }) : super(key: key);

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      // пустые инпуты не валидные
      return _kWrongPassword;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      obscureText: !isVisible,
      validator: _validate,
      decoration: InputDecoration(
        labelText: _kPassword,
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.darkBlue,
          ),
          onPressed: () {
            onShow(isVisible);
          },
        ),
      ),
    );
  }
}
