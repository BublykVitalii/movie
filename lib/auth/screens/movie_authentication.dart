import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/auth/api/client/auth_api.dart';
import 'package:movie/auth/domain/auth_repository.dart';
import 'package:movie/auth/domain/auth_service.dart';
import 'package:movie/auth/domain/user.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/screens/movies_screen/movie_screen.dart';

// ---Texts---
const _kTitle = 'Movie';
const _kEmail = 'Email';
const _kPassword = 'Password';
const _kWelcome = 'Welcome';
const _kSignInContinue = 'Sign in to continue!';
const _kWrongEmail = 'Please enter email';
const _kWrongPassword = 'Please enter password';
const _kSignIn = 'Sign in';

// ---Parameters---
const _kPadding = 15.0;
const _kHight = 60.0;
const _kFontSizeOne = 25.0;
const _kFontSizeTwo = 18.0;
const _kSizeWidth = 200.0;
const _kSizeHeight = 40.0;
const _kRadius = 18.0;

class MovieAuthentication extends StatefulWidget {
  static const _routeName = '/movie-authentication';

  const MovieAuthentication({Key? key}) : super(key: key);

  static PageRoute<MovieAuthentication> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return const MovieAuthentication();
        // return BlocProvider(
        //   create: (context) => MovieAuthentication(),
        //   child: const MovieAuthentication(),
        // );
      },
    );
  }

  @override
  State<MovieAuthentication> createState() => _MovieAuthenticationState();
}

class _MovieAuthenticationState extends State<MovieAuthentication> {
  AuthService get authService => GetIt.instance.get<AuthService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(_kTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: _kPadding,
          top: _kHight,
          right: _kPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopText(),
            const SizedBox(height: _kHight),
            _InputDataWidget(
              authUser: (user) {
                authService.postSessionWithLogin(user);
                Navigator.push(context, MovieScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InputDataWidget extends StatelessWidget {
  final ValueChanged<User> authUser;
  const _InputDataWidget({
    Key? key,
    required this.authUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: _kEmail),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _kWrongEmail;
              }
              return null;
            },
            onChanged: (text) {
              email = text;
            },
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _kWrongPassword;
              }
              return null;
            },
            onChanged: (text) {
              password = text;
            },
            obscureText: true,
            decoration: const InputDecoration(labelText: _kPassword),
          ),
          const SizedBox(height: _kHight),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  const Size(
                    _kSizeWidth,
                    _kSizeHeight,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                side: MaterialStateProperty.all(
                  const BorderSide(color: AppColors.darkBlue),
                ),
                shadowColor: MaterialStateProperty.all(AppColors.darkBlue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_kRadius)),
                ),
              ),
              child: Text(
                _kSignIn,
                style: context.theme.textTheme.bodyText1!.copyWith(
                  fontSize: _kFontSizeTwo,
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  authUser(User(username: email, password: password));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TopText extends StatelessWidget {
  const _TopText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _kWelcome,
          style: context.theme.textTheme.bodyText1!.copyWith(
            fontSize: _kFontSizeOne,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: _kPadding),
        Text(
          _kSignInContinue,
          style: context.theme.textTheme.bodyText1!.copyWith(
            fontSize: _kFontSizeTwo,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
