import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/movie/domain/movie.dart';
import 'dart:ui';

// ---Texts---
const _kScore = 'Score:';
const _kRating = 'Rating:';
const _kReleaseDate = 'Release Date:';

// ---Parameters---
const _kPadding = 15.0;
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          widget.movie.title,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _BackgroundImage(widget: widget),
            Padding(
              padding: const EdgeInsets.all(_kPadding),
              child: Row(
                children: [
                  _Poster(widget: widget),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Text(
                          title: _kScore,
                          text: '${widget.movie.voteAverage}',
                        ),
                        const SizedBox(
                          height: _kHeight,
                        ),
                        _Text(
                          title: _kRating,
                          text: '${widget.movie.adult}',
                        ),
                        const SizedBox(
                          height: _kHeight,
                        ),
                        _ReleaseDate(widget: widget),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _Description(widget: widget),
          ],
        ),
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
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.contain,
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

class _ReleaseDate extends StatelessWidget {
  const _ReleaseDate({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MovieDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          _kReleaseDate,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Text(
          DateFormat.yMMMMd('en_US').format(
            DateTime.parse(widget.movie.releaseDate),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  final MovieDetailsScreen widget;
  const _Description({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 320,
        left: 15,
        right: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.movie.title,
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
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.movie.overview,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
