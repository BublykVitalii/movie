import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/config.dart';
import 'package:movie/infrastructure/movie_image.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';
import 'package:movie/movie/screens/movie_details_screen/cubit/movie_details_cubit.dart';
import 'package:movie/movie_favorite_screen/domain/favorite_service.dart';
import 'package:movie/utils/date_time_formatting_extension.dart';

// ---Texts---
const _kScore = 'Score:';
const _kRating = 'Rating:';
const _kReleaseDate = 'Release Date:';
const _errorText = 'Error';

// ---Parameters---
const _kPadding = 15.0;
const _kHeight = 30.0;
const _kWidth = 20.0;

const _kFontSizeText = 18.0;
const _kHeightContainer = 280.0;
const _kWidthContainer = 200.0;
const _kRadius = 20.0;
const _kWithOpacity = 0.8;
const _kSigmaXY = 10.0;

class MovieDetailsScreen extends StatefulWidget {
  static const _routeName = '/movie-details-screen';

  static PageRoute<MovieDetailsScreen> route(Movie movie) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => MovieDetailsCubit(movie),
          child: const MovieDetailsScreen(),
        );
      },
    );
  }

  const MovieDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isVisible = false;
  MovieDetailsCubit get movieCubit =>
      BlocProvider.of<MovieDetailsCubit>(context);
  final MovieService movieService = GetIt.instance.get<MovieService>();

  @override
  void initState() {
    movieCubit.getMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        final Movie movie = state.movie!;

        Widget content = const Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.darkBlue,
            color: Colors.white,
          ),
        );

        if (state is MovieDetailsSuccess) {
          content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow(movie: movie),
              const SizedBox(height: _kHeight),
              _TitleText(
                movieId: movie.id,
                isVisible: isVisible,
                onShow: (value) {
                  setState(() {
                    isVisible = !value;
                  });
                },
                title: movie.title,
              ),
              _Description(overview: movie.overview),
            ],
          );
        } else if (state is MovieDetailsError) {
          content = Center(
            child: Text(
              _errorText,
              style: context.theme.textTheme.headline5!
                  .copyWith(color: Colors.white),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(movie.title),
          ),
          body: Stack(
            children: [
              _BackgroundImage(posterPath: movie.posterPath),
              Padding(
                padding: const EdgeInsets.all(_kPadding),
                child: content,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
    required this.posterPath,
  }) : super(key: key);

  final String posterPath;
  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: posterPath.isNotEmpty
          ? NetworkImage(posterPath)
          : Image.asset(
              MovieImage.movieImage,
              fit: BoxFit.cover,
            ).image,
      fit: BoxFit.cover,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _kSigmaXY,
          sigmaY: _kSigmaXY,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(_kWithOpacity),
          ),
        ),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({
    Key? key,
    required this.posterPath,
  }) : super(key: key);

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kHeightContainer,
      width: _kWidthContainer,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(_kRadius),
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
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText({
    Key? key,
    required this.voteAverage,
    required this.isAdult,
    required this.releaseDate,
  }) : super(key: key);
  final String voteAverage;
  final String isAdult;
  final String releaseDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: _kHeightContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _InfoRowText(
              subTitle: _kScore,
              text: voteAverage,
            ),
            _InfoRowText(
              subTitle: _kRating,
              text: isAdult,
            ),
            _InfoRowText(
              subTitle: _kReleaseDate,
              text: releaseDate,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  AppConfig get _config => GetIt.instance.get<AppConfig>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Poster(posterPath: movie.posterPath),
        const SizedBox(width: _kWidth),
        _InfoText(
          voteAverage: '${movie.voteAverage}',
          isAdult: movie.adultToString(movie.isAdult),
          releaseDate: movie.releaseDate!.yMMMMd(_config.language),
        ),
      ],
    );
  }
}

class _InfoRowText extends StatelessWidget {
  const _InfoRowText({
    Key? key,
    required this.subTitle,
    required this.text,
  }) : super(key: key);

  final String subTitle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: _kFontSizeText),
        children: <TextSpan>[
          TextSpan(text: subTitle),
          TextSpan(
            text: '\n$text',
            style: context.theme.textTheme.headline5!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  FavoriteService get favoriteService => GetIt.instance.get<FavoriteService>();

  final bool isVisible;
  final ValueChanged<bool> onShow;
  final String title;
  final int movieId;

  const _TitleText({
    Key? key,
    required this.isVisible,
    required this.onShow,
    required this.title,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.theme.textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                color: Colors.white,
                icon: Icon(
                  !isVisible ? Icons.favorite_border_outlined : Icons.favorite,
                ),
                onPressed: () {
                  favoriteService.markAsFavorite(movieId);
                  onShow(isVisible);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.overview,
  }) : super(key: key);

  final String? overview;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: _kHeight),
            const Divider(color: Colors.white),
            const SizedBox(height: _kHeight),
            Text(
              overview!,
              style: context.theme.textTheme.subtitle1!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: _kHeight),
            const Divider(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
