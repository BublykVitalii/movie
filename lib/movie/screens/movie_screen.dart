import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/screens/cubit/movie_cubit.dart';

// ---Texts---
const _kTitle = 'Movie';

// ---Parameters---
const _kPadding = EdgeInsets.all(10);
const _kGridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 300,
  mainAxisSpacing: 10,
  crossAxisSpacing: 10,
  childAspectRatio: 2 / 3,
);
const _kRadiusCircular = Radius.circular(15);
const double _kHeight = 30;
const double _kFontSize = 15;
const double _kBlurRadius = 3;
const double _kRadius = 15;

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
              padding: _kPadding,
              itemCount: state.movies!.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = state.movies![index];

                return MovieCard(movie: movie);
              },
              gridDelegate: _kGridDelegate,
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

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageCard(movie: movie),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              focusColor: AppColors.darkBlue,
              hoverColor: AppColors.darkBlue,
              highlightColor: AppColors.darkBlue,
              splashColor: AppColors.darkBlue,
              borderRadius: BorderRadius.circular(_kRadius),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkBlue.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            bottomLeft: _kRadiusCircular,
            bottomRight: _kRadiusCircular,
          ),
        ),
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
      ),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: _kBlurRadius,
            color: AppColors.orange,
          ),
        ],
        borderRadius: BorderRadius.circular(_kRadius),
        image: DecorationImage(
          image: NetworkImage(movie.posterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
