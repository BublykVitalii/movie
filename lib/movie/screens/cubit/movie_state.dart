import 'package:flutter/material.dart';
import 'package:movie/movie/domain/movie.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieSuccess extends MovieState {
  final Movie? movie;
  final List<Movie>? movies;

  MovieSuccess({
    this.movie,
    this.movies,
  });
}

class MovieError extends MovieState {}
