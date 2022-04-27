import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/infrastructure/movie_image.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movie/movie_favorite_screen/screen/cubit/favorite_cubit.dart';
import 'package:movie/ui_kit/drawer_menu.dart';

// ---Texts---
const _kTitle = 'Favorite Movie';

// ---Parameters---
const _kLeft = 4.0;
const _kTop = 10.0;
const _kHeight = 200.0;
const _kWidth = 140.0;
const _kCircular = 20.0;
const _kPaddingAll = 8.0;
const _kMaxLines = 2;

class FavoriteScreen extends StatefulWidget {
  static const _routeName = '/favorite-screen';

  static PageRoute<FavoriteScreen> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => FavoriteCubit(),
          child: const FavoriteScreen(),
        );
      },
    );
  }

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteCubit get favoriteCubit => BlocProvider.of<FavoriteCubit>(context);

  @override
  void initState() {
    favoriteCubit.getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(_kTitle),
      ),
      body: SafeArea(
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.darkBlue,
                  color: Colors.white,
                ),
              );
            }
            if (state is FavoriteSuccess) {
              return ListView.separated(
                padding: const EdgeInsets.only(
                  left: _kLeft,
                  top: _kTop,
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: state.listMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = state.listMovies[index];
                  return MovieCard(
                    movie: movie,
                    title: movie.title,
                    overview: movie.overview,
                    posterPath: movie.posterPath,
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final String title;
  final String? overview;
  final String posterPath;
  const MovieCard({
    Key? key,
    required this.movie,
    required this.title,
    required this.overview,
    required this.posterPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MovieDetailsScreen.route(movie));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: _kHeight,
            width: _kWidth,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(_kCircular),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: posterPath.isNotEmpty
                    ? NetworkImage(posterPath)
                    : Image.asset(
                        MovieImage.movieImage,
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
                    title,
                    style: context.theme.textTheme.subtitle1!.copyWith(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: _kMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_kPaddingAll),
                  child: Text(
                    overview!,
                    style: context.theme.textTheme.subtitle1!.copyWith(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 7,
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
