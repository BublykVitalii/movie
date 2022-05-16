import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/add_movie/cubit/add_movie_cubit.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/my_movie/cubit/my_movie_cubit.dart';

// ---Texts---
const _kTitle = 'add movie';
const _kErrorText = 'invalid text';
const _kTitleWrong = 'write title movie';
const _kOverviewWrong = 'write overview movie';

// ---Parameters---
const _kTop = 10.0;
const _kHorizontal = 8.0;
const _kHeight = 20.0;
const _kTopOne = 14.0;
const _kEight = 8.0;

class AddMovieScreen extends StatefulWidget {
  static const _routeName = '/movie-create-screen';

  static PageRoute<AddMovieScreen> route(MyMovieCubit myMovieCubit) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider.value(
          value: myMovieCubit,
          child: BlocProvider(
            create: (context) => AddMovieCubit(),
            child: const AddMovieScreen(),
          ),
        );
      },
    );
  }

  const AddMovieScreen({Key? key}) : super(key: key);

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  String? title;
  String? overview;
  Movie? movie;
  final _formKey = GlobalKey<FormState>();

  AddMovieCubit get addCubit => BlocProvider.of<AddMovieCubit>(context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMovieCubit, AddMovieState>(
      listener: (context, state) {
        if (state.status == AddMovieStatus.success) {
          BlocProvider.of<MyMovieCubit>(context).updateMovieList(state.movie!);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(_kTitle),
        ),
        body: BlocBuilder<AddMovieCubit, AddMovieState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: _kTop,
                    horizontal: _kHorizontal,
                  ),
                  child: Column(
                    children: [
                      _TitleMovie(
                        onSaved: (value) {
                          title = value;
                        },
                      ),
                      const SizedBox(height: _kHeight),
                      _OverviewMovie(
                        onSaved: (value) {
                          overview = value;
                        },
                      ),
                      const SizedBox(height: _kHeight),
                      FloatingActionButton(
                        backgroundColor: AppColors.darkBlueBackground,
                        child: const Icon(Icons.add),
                        onPressed: _onPressedSave,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onPressedSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      addCubit.createMovie(title!, overview!);
      Navigator.pop(context);
    }
  }
}

class _TitleMovie extends StatelessWidget {
  const _TitleMovie({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final ValueChanged<String?> onSaved;

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
        decoration: _ExtendedInputDecoration(_kTitleWrong),
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _kErrorText;
    }
    return null;
  }
}

class _OverviewMovie extends StatelessWidget {
  const _OverviewMovie({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final ValueChanged<String?> onSaved;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextFormField(
        onSaved: onSaved,
        validator: _validate,
        autofocus: false,
        style: context.theme.textTheme.subtitle1!
            .copyWith(color: AppColors.darkBlue),
        decoration: _ExtendedInputDecoration(_kOverviewWrong),
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _kErrorText;
    }
    return null;
  }
}

class _ExtendedInputDecoration extends InputDecoration {
  final String text;
  _ExtendedInputDecoration(
    this.text,
  ) : super(
          filled: true,
          fillColor: Colors.white,
          hintText: text,
          contentPadding: const EdgeInsets.only(
            left: _kTopOne,
            bottom: _kEight,
            top: _kEight,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(_kHeight),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(_kHeight),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(_kHeight),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(_kHeight),
          ),
        );
}
