import 'package:flutter/material.dart';
import 'package:movie/add_movie/add_movie_screen.dart';
import 'package:movie/infrastructure/movie_image.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';

// ---Texts---
const _kTitle = 'My Movie';

// ---Parameters---
const _kCircular = 20.0;
const _kLeft = 10.0;
const _kTop = 10.0;
const _kHeight = 200.0;
const _kWidth = 140.0;
const _kPaddingAll = 8.0;

class MyMovieScreen extends StatefulWidget {
  static const _routeName = '/my-movie-screen';

  static PageRoute<MyMovieScreen> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return const MyMovieScreen();
      },
    );
  }

  const MyMovieScreen({Key? key}) : super(key: key);

  @override
  State<MyMovieScreen> createState() => _MyMovieScreenState();
}

class _MyMovieScreenState extends State<MyMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(_kTitle),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(
                left: _kLeft,
                top: _kTop,
                right: _kLeft,
              ),
              children: const [
                _MovieCard(),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, AddMovieScreen.route());
                },
                backgroundColor: AppColors.darkBlueBackground,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0.2,
          )
        ],
        color: AppColors.darkBlueBackground,
        border: Border.all(
          width: 10,
          color: AppColors.darkBlueBackground,
        ),
        borderRadius: BorderRadius.circular(_kCircular),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _kWidth,
            height: _kHeight,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppColors.darkBlueRadius,
                  spreadRadius: 3,
                  blurRadius: 3,
                  blurStyle: BlurStyle.solid,
                )
              ],
              border: Border.all(
                width: 0.5,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(_kCircular),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  MovieImage.posterImage,
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
                    'title',
                    style: context.theme.textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_kPaddingAll),
                  child: Text(
                    'overview!',
                    style: context.theme.textTheme.subtitle1!.copyWith(
                      color: Colors.white,
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
