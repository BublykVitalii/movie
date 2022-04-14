import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/auth/domain/auth_service.dart';
import 'package:movie/auth/domain/user.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/screens/movies_screen/movie_screen.dart';

// ---Texts---
const _kTitle = 'Movie';
const _kUsername = 'Username';
const _kPassword = 'Password';
const _kWelcome = 'Welcome';
const _kSignInContinue = 'Sign in to continue!';
const _kWrongUsername = 'Please enter username';
const _kWrongPassword = 'Please enter password';
const _kSignIn = 'Sign in';

// ---Parameters---
const _kPadding = 15.0;
const _kTop = 60.0;
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
        padding: const EdgeInsets.fromLTRB(_kPadding, _kTop, _kPadding, 0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TopText(),
              const SizedBox(height: _kTop),
              _InputDataWidget(
                authUser: (user) {
                  authService.postSessionWithLogin(user);
                  Navigator.push(context, MovieScreen.route);
                },
              ),
            ],
          ),
        ),
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

class _InputDataWidget extends StatefulWidget {
  final ValueChanged<User> authUser;
  const _InputDataWidget({
    Key? key,
    required this.authUser,
  }) : super(key: key);

  @override
  State<_InputDataWidget> createState() => _InputDataWidgetState();
}

class _InputDataWidgetState extends State<_InputDataWidget> {
  late TextEditingController _userPasswordController;
  bool _passwordVisible = false;

  @override
  void initState() {
    _userPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    String password = '';
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: _kUsername),
            validator: validate,
            onChanged: (text) {
              username = text;
            },
          ),
          TextFormField(
            controller: _userPasswordController,
            obscureText: !_passwordVisible,
            validator: validate,
            onChanged: (text) {
              password = text;
            },
            decoration: InputDecoration(
              labelText: _kPassword,
              suffixIcon: IconButton(
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      _passwordVisible = !_passwordVisible;
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: _kTop),
          Center(
            child: SignInButton(
              formKey: _formKey,
              widget: widget,
              username: username,
              password: password,
            ),
          ),
        ],
      ),
    );
  }

  String? validate(value) {
    if (value == null || value.isEmpty) {
      return value;
    }
    return null;
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.widget,
    required this.username,
    required this.password,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final _InputDataWidget widget;
  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kRadius)),
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
          widget.authUser(User(username: username, password: password));
        }
      },
    );
  }
}
