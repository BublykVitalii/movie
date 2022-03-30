import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/config.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/screens/movies_screen/cubit/movie_cubit.dart';
import 'package:movie/utils/date_time_formatting_extension.dart';

// ---Texts---
const _kScore = 'Score:';
const _kRating = 'Rating:';
const _kReleaseDate = 'Release Date:';

// ---Parameters---
const _kPadding = 15.0;
const _kHeight = 30.0;
const _kWidth = 20.0;

class MovieDetailsScreen extends StatefulWidget {
  static const _routeName = '/movie-details-screen';

  static PageRoute<MovieDetailsScreen> route(
      int id, Movie movie, MovieCubit movieCubit) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider.value(
          value: movieCubit,
          child: MovieDetailsScreen(movie: movie),
        );
      },
    );
  }

  final Movie movie;
  const MovieDetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieCubit get movieCubit => BlocProvider.of<MovieCubit>(context);
  AppConfig get _config => GetIt.instance.get<AppConfig>();
  @override
  void initState() {
    movieCubit.getMovie(widget.movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        String title = '';
        if (state is MovieSuccess) {
          title = state.movie!.title;
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(title),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                BackgroundImage(posterPath: widget.movie.posterPath),
                Padding(
                  padding: const EdgeInsets.all(_kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(
                        posterPath: widget.movie.posterPath,
                        voteAverage: '${widget.movie.voteAverage}',
                        isAdult: '${widget.movie.isAdult}',
                        releaseDate:
                            widget.movie.releaseDate!.yMMMMd(_config.language),
                      ),
                      const SizedBox(height: _kHeight),
                      TitleText(title: widget.movie.title),
                      Description(overview: widget.movie.overview),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key? key,
    required this.posterPath,
    required this.voteAverage,
    required this.isAdult,
    required this.releaseDate,
  }) : super(key: key);
  final String posterPath;
  final String voteAverage;
  final String isAdult;
  final String releaseDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Poster(posterPath: posterPath),
        const SizedBox(width: _kWidth),
        InfoText(
          voteAverage: voteAverage,
          isAdult: isAdult,
          releaseDate: releaseDate,
        ),
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.posterPath,
  }) : super(key: key);

  final String posterPath;
  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: NetworkImage(posterPath),
      fit: BoxFit.cover,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}

class Poster extends StatelessWidget {
  const Poster({
    Key? key,
    required this.posterPath,
  }) : super(key: key);

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(posterPath),
        ),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText({
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
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _Text(
              title: _kScore,
              text: voteAverage,
            ),
            _Text(
              title: _kRating,
              text: isAdult,
            ),
            _Text(
              title: _kReleaseDate,
              text: releaseDate,
            ),
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18,
        ),
        children: <TextSpan>[
          TextSpan(text: title),
          TextSpan(
            text: '\n$text',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.theme.textTheme.bodyText1!.copyWith(
        fontSize: 22.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
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
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              height: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              overview!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
