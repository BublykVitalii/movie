import 'package:flutter/material.dart';

import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/ui_kit/drawer_menu.dart';

// ---Texts---
const _kTitle = 'add movie';

class AddMovieScreen extends StatefulWidget {
  static const _routeName = '/movie-create-screen';

  static PageRoute<AddMovieScreen> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return const AddMovieScreen();
      },
    );
  }

  const AddMovieScreen({Key? key}) : super(key: key);

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  String? titleText;
  String? descriptionText;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(_kTitle),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 10,
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              children: [
                _TitleMovie(
                  onSaved: (value) {
                    titleText = value;
                  },
                ),
                const SizedBox(height: 20),
                _DescriptionMovie(
                  onSaved: (value) {
                    descriptionText = value;
                  },
                ),
                FloatingActionButton(
                  onPressed: _onPressedSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}

class _TitleMovie extends StatelessWidget {
  const _TitleMovie({
    Key? key,
    required this.onSaved,
    this.titleText,
  }) : super(key: key);

  final ValueChanged<String?> onSaved;
  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextFormField(
        validator: _validate,
        onSaved: onSaved,
        autofocus: false,
        style: context.theme.textTheme.subtitle1!
            .copyWith(color: AppColors.darkBlue),
        decoration: InputDecoration(
          labelText: titleText,
          filled: true,
          fillColor: Colors.white,
          hintText: 'write title movie',
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'not text';
    }
    return null;
  }
}

class _DescriptionMovie extends StatelessWidget {
  const _DescriptionMovie({
    Key? key,
    required this.onSaved,
    this.descriptionText,
  }) : super(key: key);

  final ValueChanged<String?> onSaved;
  final String? descriptionText;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextFormField(
        validator: _validate,
        autofocus: false,
        style: context.theme.textTheme.subtitle1!
            .copyWith(color: AppColors.darkBlue),
        decoration: InputDecoration(
          labelText: descriptionText,
          filled: true,
          fillColor: Colors.white,
          hintText: 'write description movie',
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'not text';
    }
    return null;
  }
}
