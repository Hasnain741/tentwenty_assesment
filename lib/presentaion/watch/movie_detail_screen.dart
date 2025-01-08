import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assesment/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:tentwenty_assesment/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:tentwenty_assesment/bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:tentwenty_assesment/presentaion/get_tickets/get_ticket_screen.dart';
import 'package:tentwenty_assesment/utils/colors.dart';
import 'package:tentwenty_assesment/utils/helper_function.dart';
import 'package:tentwenty_assesment/models/movie_detail_model.dart';
import 'package:tentwenty_assesment/provider/movie_player_provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String movieId;

  const MovieDetailScreen(
      {super.key, required this.imageUrl, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailBloc movieDetailBloc = MovieDetailBloc();
  String? trailerId;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    movieDetailBloc.add(HitMovieDetail(movieId: widget.movieId));
    movieDetailBloc.add(HitGetMovieTrailer(movieId: widget.movieId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(
              create: (BuildContext context) => movieDetailBloc),
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<MovieDetailBloc, MovieDetailState>(
                listener: (context, state) {
                  if (state is MovieDetailError) {
                  } else if (state is MovieDetailLoaded) {
                  } else if (state is GetMovieTrailerError) {
                  } else if (state is GetMovieTrailerLoaded) {
                    trailerId =
                        state.movieTrailerModel.results?.last?.key ?? "";
                  }
                },
              ),
            ],
            child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
              builder: (context, state) {
                if (state is MovieDetailInitialState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieDetailLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieDetailLoaded) {
                  trailerId =state.key ?? "";
                  return buildScreen(context, state.movieDetailModel!);
                } else {
                  return Container();
                }
              },
            )));
  }

  Widget buildScreen(BuildContext context, MovieDetailModel model) {
    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Watch",
          style: createCustomTextStyle(
              fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        // Remove app bar shadow
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: mediaQueryData.orientation == Orientation.landscape
          ? Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context)
                          .size
                          .height, // Adjust as needed
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.imageUrl),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        child: Column(
                          children: [
                            Text(
                              "In Theaters ${formatDateString(model.releaseDate ?? "2023-09-08")}",
                              style: createCustomTextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GetTicketScreen(
                                                    movieName:
                                                        model.originalTitle ??
                                                            "",
                                                    movieDetailModel: model)));
                                  },
                                  child: Container(
                                    height: 50,
                                    constraints:
                                        const BoxConstraints(minWidth: 140),
                                    decoration: BoxDecoration(
                                      color: lightBlue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Center(
                                      child: Text(
                                        "Get Tickets",
                                        style: createCustomTextStyle(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16), // Set text color
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<MoviePlayerProvider>(context,
                                            listen: false)
                                        .playMovieTrailer(context, trailerId!);
                                  },
                                  child: Container(
                                    height: 50,
                                    constraints:
                                        const BoxConstraints(minWidth: 140),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: lightBlue, width: 1.0)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: whiteColor,
                                        ),
                                        Text(
                                          "Watch Trailer",
                                          style: createCustomTextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16), // Set text color
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Genres",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: model.genres?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getRandomColor(),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Center(
                                      child: Text(
                                        model.genres?[index]?.name ?? "",
                                        style: createCustomTextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          hDivider(),
                          const Text(
                            "Overview",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            model.overview ?? "",
                            style: createCustomTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: fontColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.6, // Adjust as needed
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.imageUrl),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        child: Column(
                          children: [
                            Text(
                              "In Theaters ${formatDateString(model.releaseDate ?? "2023-09-08")}",
                              style: createCustomTextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GetTicketScreen(
                                            movieName:
                                                model.originalTitle ?? "",
                                            movieDetailModel: model)));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: lightBlue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60.0),
                                  child: Center(
                                    child: Text(
                                      "Get Tickets",
                                      style: createCustomTextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16), // Set text color
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<MoviePlayerProvider>(context,
                                        listen: false)
                                    .playMovieTrailer(context, trailerId!);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: lightBlue, width: 1.0)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        color: whiteColor,
                                      ),
                                      Text(
                                        "Watch Trailer",
                                        style: createCustomTextStyle(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16), // Set text color
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Genres",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: model.genres?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getRandomColor(),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Center(
                                      child: Text(
                                        model.genres?[index]?.name ?? "",
                                        style: createCustomTextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          hDivider(),
                          const Text(
                            "Overview",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            model.overview ?? "",
                            style: createCustomTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: fontColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
