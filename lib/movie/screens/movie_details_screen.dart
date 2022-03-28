import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie/movie/domain/movie.dart';

// ---Parameters---
const _kPadding = 15.0;
const double _kWidth = 20;
const double _kHeight = 60;

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
        ),
      ),
      body: Stack(
        children: [
          _BackgroundImage(widget: widget),
          Padding(
            padding: const EdgeInsets.all(_kPadding),
            child: Row(
              children: [
                _Poster(widget: widget),
                const SizedBox(width: _kWidth),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Text(
                        title: 'Score:',
                        text: '${widget.movie.voteAverage}',
                      ),
                      const SizedBox(
                        height: _kHeight,
                      ),
                      _Text(
                        title: 'Rating:',
                        text: '${widget.movie.adult}',
                      ),
                      const SizedBox(
                        height: _kHeight,
                      ),
                      _Text(
                        title: 'Release Date:',
                        text: '${widget.movie.releaseDate}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 230,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${widget.movie.title}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    '${widget.movie.overview}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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
          ),
        ],
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MovieDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(widget.movie.posterPath),
          ),
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
          fontSize: 20,
        ),
        children: <TextSpan>[
          const TextSpan(
            style: TextStyle(),
          ),
          TextSpan(text: title),
          TextSpan(
            text: '\n$text',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MovieDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: NetworkImage(widget.movie.posterPath),
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
