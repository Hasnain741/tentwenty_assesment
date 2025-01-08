import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_assesment/presentaion/watch/movie_detail_screen.dart';
import 'package:tentwenty_assesment/utils/colors.dart';
import 'package:tentwenty_assesment/models/upcoming_movie_model.dart';
import 'package:tentwenty_assesment/utils/const_url.dart';

class Search extends StatefulWidget {
  final UpcomingMovieModel model;

  const Search({super.key, required this.model});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<UpcomingMovieModelResults?>? filter = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        titleSpacing: 10.0,
        title: Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          color: Colors.white,
          child: TextField(
            controller: searchController,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.text,
            onChanged: (String? value) {
              final searchText = value?.toLowerCase();

              setState(() {
                filter = widget.model.results
                    ?.where((movie) =>
                        movie?.originalTitle
                            ?.toLowerCase()
                            .contains(searchText!) ??
                        false)
                    .toList();
              });
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: primary,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: primary,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
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
                  Navigator.pop(context);
                  // Clear the text or perform cancel action
                },
              ),
              fillColor: primary,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          filter!.isEmpty
              ? Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.3,
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0),
                    itemCount: widget.model.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      final imageUrl =
                          widget.model.results?[index]?.posterPath ?? "";

                      return Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                    imageUrl: "$imageBaseUrl$imageUrl",
                                    movieId: widget.model.results?[index]?.id
                                            .toString() ??
                                        "",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "$imageBaseUrl$imageUrl"),
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
                                widget.model.results?[index]?.title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                strutStyle: const StrutStyle(
                                  forceStrutHeight: true,
                                ),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0),
                    itemCount: filter?.length ?? 0,
                    itemBuilder: (context, index) {
                      final imageUrl = filter?[index]?.posterPath ?? "";
                      return Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                    imageUrl: "$imageBaseUrl$imageUrl",
                                    movieId:
                                        filter?[index]?.id.toString() ?? "",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "$imageBaseUrl$imageUrl"),
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
                                filter?[index]?.title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                strutStyle: const StrutStyle(
                                  forceStrutHeight: true,
                                ),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
