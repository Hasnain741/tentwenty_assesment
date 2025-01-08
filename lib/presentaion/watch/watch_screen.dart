import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tentwenty_assesment/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:tentwenty_assesment/bloc/upcoming_movie_bloc/upcoming_movie_event.dart';
import 'package:tentwenty_assesment/bloc/upcoming_movie_bloc/upcoming_movie_state.dart';
import 'package:tentwenty_assesment/models/upcoming_movie_model.dart';
import 'package:tentwenty_assesment/presentaion/watch/movie_detail_screen.dart';
import 'package:tentwenty_assesment/utils/colors.dart';
import 'package:tentwenty_assesment/utils/const_url.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  UpcomingMovieBloc upcomingMovieBloc = UpcomingMovieBloc();
  UpcomingMovieModel? upcomingMovieModel;
  bool searchMode = false;
  TextEditingController searchController = TextEditingController();
  List<UpcomingMovieModelResults?>? filter = [];

  @override
  void initState() {
    // TODO: implement initState
    upcomingMovieBloc.add(GetUpcomingMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return searchMode ? _buildSearchMode() : _buildNormalMode();
  }

  Widget _buildSearchMode() {
    return Scaffold(
      backgroundColor: primary,
      appBar: _buildSearchAppBar(),
      body: _buildMovieGrid(filter),
    );
  }

  Widget _buildNormalMode() {
    return Scaffold(
      backgroundColor: gray100,
      appBar: _buildNormalAppBar(),
      body: BlocProvider(
        create: (_) => upcomingMovieBloc,
        child: BlocListener<UpcomingMovieBloc, UpcomingMovieState>(
          listener: (context, state) {
            if (state is UpcomingMovieLoaded) {
              upcomingMovieModel = state.upcomingMovieModel;
            }
          },
          child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
            builder: (context, state) {
              if (state is UpcomingMovieInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UpcomingMovieLoaded) {
                return _buildMovieList(context, state.upcomingMovieModel);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildSearchAppBar() {
    return AppBar(
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      titleSpacing: 10.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: _buildSearchTextField(),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      color: Colors.transparent,
      child: TextField(
        controller: searchController,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.text,
        onChanged: (String? value) {
          final searchText = value?.toLowerCase();
          setState(() {
            filter = upcomingMovieModel!.results
                ?.where((movie) =>
                    movie?.originalTitle?.toLowerCase().contains(searchText!) ??
                    false)
                .toList();
          });
        },
        decoration: InputDecoration(
          focusedBorder: _buildTextFieldBorder(),
          enabledBorder: _buildTextFieldBorder(),
          errorBorder: _buildTextFieldBorder(),
          filled: true,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xffA7A7A7),
          ),
          hintText: "Tv Show, Movie, and more",
          prefixIcon: Icon(Icons.search, color: blackColor),
          suffixIcon: IconButton(
            icon: SvgPicture.asset("assets/remove.svg",
                height: 20, color: blackColor),
            onPressed: () {
              setState(() {
                searchMode = false;
              });
            },
          ),
          fillColor: primary,
        ),
      ),
    );
  }

  OutlineInputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primary, width: 1),
    );
  }

  Widget _buildMovieGrid(List<UpcomingMovieModelResults?>? movieList) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: movieList?.length ?? 0,
      itemBuilder: (context, index) {
        final imageUrl = movieList?[index]?.posterPath ?? "";
        return _buildMovieTile(imageUrl, movieList, index);
      },
    );
  }

  Widget _buildMovieTile(
      String imageUrl, List<UpcomingMovieModelResults?>? movieList, int index) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          onTap: () => _navigateToMovieDetail(context, movieList, index),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: CachedNetworkImageProvider("$imageBaseUrl$imageUrl"),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.overlay,
                ),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 18.0,
          child: SingleChildScrollView(
            child: Text(
              movieList?[index]?.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(forceStrutHeight: true),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToMovieDetail(BuildContext context,
      List<UpcomingMovieModelResults?>? movieList, int index) {
    final imageUrl = movieList?[index]?.posterPath ?? "";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(
          imageUrl: "$imageBaseUrl$imageUrl",
          movieId: movieList?[index]?.id.toString() ?? "",
        ),
      ),
    );
  }

  AppBar _buildNormalAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Watch",
          style: TextStyle(
            fontFamily: "Poppins",
            color: blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            setState(() {
              searchMode = true;
            });
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 28.0),
            child: Icon(Icons.search),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieList(BuildContext context, UpcomingMovieModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 70),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 20),
        itemCount: model.results?.length ?? 0,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final imageUrl = model.results?[index]?.posterPath ?? "";
          return _buildMovieTile(imageUrl, model.results, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
