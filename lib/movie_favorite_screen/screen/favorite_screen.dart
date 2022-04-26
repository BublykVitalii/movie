import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/infrastructure/movie_image.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie_favorite_screen/cubit/favorite_cubit.dart';
import 'package:movie/ui_kit/drawer_menu.dart';

// ---Texts---
const _kTitle = 'Favorite Movie';

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
              return Padding(
                padding: const EdgeInsets.only(
                  left: 6.0,
                  top: 10,
                ),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: state.listMovies.length,
                  itemBuilder: (BuildContext context, int index) {
                    final movie = state.listMovies[index];
                    return MovieCard(
                      title: movie.title,
                      overview: movie.overview,
                      posterPath: movie.posterPath,
                    );
                  },
                ),
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
  final String title;
  final String? overview;
  final String posterPath;
  const MovieCard({
    Key? key,
    required this.title,
    required this.overview,
    required this.posterPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          width: 140,
          child: Ink.image(
            image: posterPath.isNotEmpty
                ? NetworkImage(posterPath)
                : Image.asset(
                    MovieImage.movieImage,
                    fit: BoxFit.cover,
                  ).image,
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: context.theme.textTheme.subtitle1!.copyWith(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 220,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  overview!,
                  style: context.theme.textTheme.subtitle1!.copyWith(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
