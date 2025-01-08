import 'package:flutter/material.dart';
import 'package:tentwenty_assesment/presentaion/watch/movie_player_screen.dart';

class MoviePlayerProvider with ChangeNotifier {
  void playMovieTrailer(BuildContext context, String videoId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoviePlayerScreen(videoId: videoId),
      ),
    );
  }
}