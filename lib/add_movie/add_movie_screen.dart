import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/add_movie/cubit/add_movie_cubit.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';

import 'package:movie/my_movie/cubit/my_movie_cubit.dart';

// ---Texts---
const _kTitle = 'add movie';

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
  String? description;

  final _formKey = GlobalKey<FormState>();

  _AddMovieScreenState();
  AddMovieCubit get addCubit => BlocProvider.of<AddMovieCubit>(context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMovieCubit, AddMovieState>(
      listener: (context, state) {
        if (state.status == AddMovieStatus.success) {
          BlocProvider.of<MyMovieCubit>(context).data(
            title!,
            description!,
          );
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
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Column(
                    children: [
                      _TitleMovie(
                        onSaved: (value) {
                          title = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      _DescriptionMovie(
                        onSaved: (value) {
                          description = value;
                        },
                      ),
                      const SizedBox(height: 20),
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
      addCubit.saveTitleDescription(title!, description!);
      Navigator.pop(context);
    }
  }
}

class _TitleMovie extends StatelessWidget {
  const _TitleMovie({
    Key? key,
    required this.onSaved,
    this.title,
  }) : super(key: key);

  final ValueChanged<String?> onSaved;
  final String? title;

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
          labelText: title,
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
    this.description,
  }) : super(key: key);

  final ValueChanged<String?> onSaved;
  final String? description;

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
        decoration: InputDecoration(
          labelText: description,
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
