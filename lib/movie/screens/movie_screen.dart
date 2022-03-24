import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie/screens/cubit/movie_cubit.dart';
import 'package:movie/movie/screens/cubit/movie_state.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie'),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieInitial) {
            return IconButton(
              onPressed: () {
                movieCubit.getMovieNowPlaying(1);
              },
              icon: Icon(Icons.dangerous),
            );
          }

          if (state is MovieSuccess && state.movies != null) {
            ListView.builder(
              itemCount: state.movies!.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = state.movies?[index];
                print('$movie');
                return Container();
              },
            );
          }
          if (state is MovieSuccess && state.movie != null) {}

          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieSuccess) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(15),
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
