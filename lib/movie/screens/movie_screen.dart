import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/movie/screens/cubit/movie_cubit.dart';

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
        title: const Text('Movie'),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieSuccess && state.movies != null) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.movies!.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = state.movies![index];

                return Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkBlue.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 30,
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: AppColors.darkBlue,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(movie.posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 3,
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
