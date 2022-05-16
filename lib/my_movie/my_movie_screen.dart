import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/add_movie/add_movie_screen.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/my_movie/cubit/my_movie_cubit.dart';

// ---Texts---
const _kTitle = 'My Movie';

// ---Parameters---
const _kCardPadding = 10.0;
const _kHeight = 200.0;
const _kWidth = 140.0;
const _kPaddingAll = 8.0;
const _spreadRadius = 0.2;
const _kWidthOne = 10.0;
const _kWidthTwo = 0.5;
const _kRadius = 3.0;
const _kMaxLineOne = 2;
const _kMaxLineTwo = 7;

class MyMovieScreen extends StatefulWidget {
  static const _routeName = '/my-movie-screen';

  static PageRoute<MyMovieScreen> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => MyMovieCubit(),
          child: const MyMovieScreen(),
        );
      },
    );
  }

  const MyMovieScreen({Key? key}) : super(key: key);

  @override
  State<MyMovieScreen> createState() => _MyMovieScreenState();
}

class _MyMovieScreenState extends State<MyMovieScreen> {
  MyMovieCubit get myMovieCubit => BlocProvider.of<MyMovieCubit>(context);

  @override
  void initState() {
    myMovieCubit.getMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(_kTitle),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              AddMovieScreen.route(myMovieCubit),
            );
          },
          backgroundColor: AppColors.darkBlueBackground,
          child: const Icon(Icons.add),
        ),
      ),
      body: BlocBuilder<MyMovieCubit, MyMovieState>(
        builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: ListView.separated(
              padding: const EdgeInsets.all(_kCardPadding),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: state.listMovie?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                List<Movie> movies = state.listMovie ?? [];
                return _MovieCard(
                  movie: movies[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: _spreadRadius,
          )
        ],
        color: AppColors.darkBlueBackground,
        border: Border.all(
          width: _kWidthOne,
          color: AppColors.darkBlueBackground,
        ),
        borderRadius: BorderRadius.circular(_kCardPadding),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _kWidth,
            height: _kHeight,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppColors.darkBlueRadius,
                  spreadRadius: _kRadius,
                  blurRadius: _kRadius,
                  blurStyle: BlurStyle.solid,
                )
              ],
              border: Border.all(
                width: _kWidthTwo,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(_kCardPadding),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  movie.posterPath!,
                  fit: BoxFit.cover,
                ).image,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(_kPaddingAll),
                  child: Text(
                    movie.title ?? '-',
                    style: context.theme.textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: _kMaxLineOne,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_kPaddingAll),
                  child: Text(
                    movie.overview ?? '--',
                    style: context.theme.textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: _kMaxLineTwo,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
