import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/screens/cubit/movie_cubit.dart';
import 'package:movie/movie/screens/movie_details_screen.dart';
import 'package:movie/ui_kit/drawer_menu.dart';

// ---Texts---
const _kTitle = 'Movie';

// ---Parameters---
const _kPadding = 10.0;
const double _kHeight = 30;
const double _kFontSize = 15;
const double _kRadius = 15;
const double _maxCrossAxisExtent = 300;
const double _childAspectRatio = 2 / 3;

class MovieScreen extends StatefulWidget {
  static const _routeName = '/movie-screen';

  static PageRoute get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => MovieCubit(),
          child: const MovieScreen(),
        );
      },
    );
  }

  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieCubit get movieCubit => BlocProvider.of<MovieCubit>(context);

  @override
  void initState() {
    movieCubit.getNowPlaying(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text(_kTitle),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieSuccess && state.movies != null) {
            return GridView.builder(
              padding: const EdgeInsets.all(_kPadding),
              itemCount: state.movies!.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = state.movies![index];

                return _MovieCard(movie: movie);
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: _maxCrossAxisExtent,
                mainAxisSpacing: _kPadding,
                crossAxisSpacing: _kPadding,
                childAspectRatio: _childAspectRatio,
              ),
            );
          } else if (state is MovieError) {
            return const Center();
          }

          return const SizedBox();
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
    return Material(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shadowColor: AppColors.darkBlue,
      borderRadius: BorderRadius.circular(_kRadius),
      child: InkWell(
        onTap: () {
          //BlocProvider.of<MovieCubit>(context).getMovieId(movie.id);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(
                movie: movie,
              ),
            ),
          );
        },
        child: Ink.image(
          image: NetworkImage(movie.posterPath),
          fit: BoxFit.cover,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Ink(
              color: AppColors.darkBlue.withOpacity(0.8),
              child: _TitleTile(movie: movie),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleTile extends StatelessWidget {
  const _TitleTile({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: _kHeight,
      child: Text(
        movie.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: _kFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
