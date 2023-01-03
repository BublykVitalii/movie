import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/infrastructure/movie_image.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';
import 'package:movie/movie/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movie/movie/screens/movies_screen/cubit/movie_cubit.dart';
import 'package:movie/ui_kit/drawer_menu.dart';

// ---Texts---
const _kTitle = 'Movie';

// ---Parameters---
const double _kPadding = 10.0;
const double _kHeight = 30;
const double _kFontSize = 15;
const double _kRadius = 15;
const double _maxCrossAxisExtent = 300;
const double _childAspectRatio = 2 / 3;
const double _kPaddingLeftRight = 20;

class MovieScreen extends StatefulWidget {
  static const _routeName = '/movie-screen';

  static PageRoute<MovieScreen> get route {
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

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    movieCubit.getMovies(MoviesCategory.nowPlaying);
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final triggerFetchMoreSize =
        0.9 * _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels > triggerFetchMoreSize) {
      movieCubit.loadMoreMoviesList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        actions: [PopUpMenu(movieCubit: movieCubit)],
        centerTitle: true,
        title: const Text(_kTitle),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state.status == MovieStatus.error) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: context.theme.textTheme.headline5!
                    .copyWith(color: Colors.red),
              ),
            );
          } else if (state.status == MovieStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final isLoadMore = state.status == MovieStatus.loadMore;
          final normalizedItemCount =
              state.movies.length + (isLoadMore ? 2 : 0);

          return GridView.builder(
            itemBuilder: (_, index) => _buildItemCard(index, state.movies),
            itemCount: normalizedItemCount,
            controller: _scrollController,
            padding: const EdgeInsets.all(_kPadding),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: _maxCrossAxisExtent,
              mainAxisSpacing: _kPadding,
              crossAxisSpacing: _kPadding,
              childAspectRatio: _childAspectRatio,
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemCard(int index, List<Movie> movies) {
    final isLoadingVisible = index >= movies.length;

    if (isLoadingVisible) {
      return const BottomLoader();
    }

    return _MovieCard(movie: movies[index]);
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
          Navigator.push(context, MovieDetailsScreen.route(movie));
        },
        child: Ink.image(
          image: movie.posterPath!.isNotEmpty
              ? NetworkImage(movie.posterPath!)
              : Image.asset(
                  MovieImage.movieImage,
                  fit: BoxFit.cover,
                ).image,
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
      padding: const EdgeInsets.only(
        left: _kPaddingLeftRight,
        right: _kPaddingLeftRight,
      ),
      alignment: Alignment.center,
      height: _kHeight,
      child: Text(
        movie.title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontSize: _kFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        child: CircularProgressIndicator(
          color: AppColors.darkBlue,
        ),
      ),
    );
  }
}

class PopUpMenu extends StatelessWidget {
  final MovieCubit movieCubit;
  MovieService get moviesService => GetIt.instance.get<MovieService>();
  const PopUpMenu({Key? key, required this.movieCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MoviesCategory>(
      itemBuilder: (context) => _popupMenuItem(),
      onSelected: (MoviesCategory value) {
        movieCubit.getMovies(value);
      },
    );
  }

  List<PopupMenuEntry<MoviesCategory>> _popupMenuItem() {
    const List<MoviesCategory> popUpMenuItem = [
      MoviesCategory.nowPlaying,
      MoviesCategory.popular,
      MoviesCategory.topRated,
      MoviesCategory.upcoming,
    ];
    return popUpMenuItem
        .map(
          (value) => PopupMenuItem(
            value: value,
            child: Text(moviesService.movieCategoryToString(value)),
          ),
        )
        .toList();
  }
}
