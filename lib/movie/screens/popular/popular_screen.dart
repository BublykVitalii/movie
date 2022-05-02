import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/infrastructure/movie_image.dart';

import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movie/movie/screens/movies_screen/movie_screen.dart';
import 'package:movie/movie/screens/popular/cubit/popular_cubit.dart';
import 'package:movie/movie/screens/top_rated/top_rated_screen.dart';
import 'package:movie/movie/screens/upcoming/upcoming_screen.dart';
import 'package:movie/ui_kit/drawer_menu.dart';

// ---Texts---
const _kTitle = 'Popular';

// ---Parameters---
const double _kPadding = 10.0;
const double _kHeight = 30;
const double _kFontSize = 15;
const double _kRadius = 15;
const double _maxCrossAxisExtent = 300;
const double _childAspectRatio = 2 / 3;
const double _kPaddingLeftRight = 20;

class PopularScreen extends StatefulWidget {
  static const _routeName = '/popular-screen';

  static PageRoute<PopularScreen> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => TopRatedCubit(),
          child: const PopularScreen(),
        );
      },
    );
  }

  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  TopRatedCubit get popularCubit => BlocProvider.of<TopRatedCubit>(context);

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    popularCubit.getPopular();
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final triggerFetchMoreSize =
        0.9 * _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels > triggerFetchMoreSize) {
      popularCubit.loadMorePopularMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        actions: const [
          DropDownMenu(),
        ],
        centerTitle: true,
        title: const Text(_kTitle),
      ),
      body: BlocBuilder<TopRatedCubit, PopularState>(
        builder: (context, state) {
          if (state.status == PopularStatus.error) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: context.theme.textTheme.headline5!
                    .copyWith(color: Colors.red),
              ),
            );
          } else if (state.status == PopularStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final isLoadMore = state.status == PopularStatus.loadMore;
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
          image: movie.posterPath.isNotEmpty
              ? NetworkImage(movie.posterPath)
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
        movie.title,
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

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    String _selectedGender = 'Movie';
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: _selectedGender,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
          size: 30,
        ),
        style: const TextStyle(color: AppColors.darkBlue),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        items: _dropDownItem(),
        onChanged: (value) {
          _selectedGender = value.toString();
          switch (value) {
            case 'Movie':
              Navigator.push(context, MovieScreen.route);
              break;
            case 'Popular':
              Navigator.push(context, PopularScreen.route);
              break;
            case 'Top rated':
              Navigator.push(context, TopRatedScreen.route);
              break;
            case 'Upcoming':
              Navigator.push(context, UpcomingScreen.route);
              break;
          }
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> dropDownItem = [
      'Movie',
      'Popular',
      'Top rated',
      'Upcoming',
    ];
    return dropDownItem
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }
}
