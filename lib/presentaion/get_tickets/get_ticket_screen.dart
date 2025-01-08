import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_assesment/presentaion/get_tickets/book_seat.dart';
import 'package:tentwenty_assesment/utils/colors.dart';
import 'package:tentwenty_assesment/utils/helper_function.dart';
import 'package:tentwenty_assesment/models/movie_detail_model.dart';

class GetTicketScreen extends StatefulWidget {
  final String movieName;
  final MovieDetailModel movieDetailModel;

  const GetTicketScreen(
      {super.key, required this.movieName, required this.movieDetailModel});

  @override
  State<GetTicketScreen> createState() => _GetTicketScreenState();
}

class _GetTicketScreenState extends State<GetTicketScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text(
                widget.movieName,
                style: createCustomTextStyle(
                    fontSize: 16,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "In Theaters ${formatDateString(widget.movieDetailModel.releaseDate ?? "2023-09-08")}",
                style: createCustomTextStyle(
                    fontSize: 16,
                    color: lightBlue,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            // Set the height of the divider
            child: Divider(
              color: Colors.grey, // Choose the color of the divider
              thickness: 1, // Set the thickness of the divider
            ),
          ),
          // Remove app bar shadow
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "Date",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          // Assuming you have a start date, you can add days to it
                          DateTime startDate =
                              DateTime.now().add(Duration(days: index));

                          // Format the date using the intl package
                          String formattedDate =
                              DateFormat('d MMM').format(startDate);
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? lightBlue
                                      : lightCream,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Center(
                                  child: Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: currentIndex == index
                                          ? whiteColor
                                          : blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "12:30",
                                      style: createCustomTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Cinetex + Hall 1",
                                      style: createCustomTextStyle(
                                          color: fontColor, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                // Set a fixed width for the container
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.lightBlue),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 30),
                                  child:
                                      SvgPicture.asset("assets/book_seat.svg"),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'From',
                                        style: TextStyle(
                                            fontSize: 16,
                                            // Set the desired font size
                                            color: fontColor),
                                      ),
                                      TextSpan(
                                        text: '50\$',
                                        style: TextStyle(
                                            fontSize: 16,
                                            // Set the desired font size
                                            fontWeight: FontWeight.bold,
                                            color: blackColor),
                                      ),
                                      TextSpan(
                                        text: ' or ',
                                        style: TextStyle(
                                            fontSize: 16, color: fontColor),
                                      ),
                                      TextSpan(
                                        text: '2500 bonus',
                                        style: TextStyle(
                                            fontSize: 16,
                                            // Set the desired font size
                                            fontWeight: FontWeight.bold,
                                            color: blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16.0, bottom: 16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookSeat(
                                movieName: widget.movieName ,
                                releaseDate: formatDateString(
                                    widget.movieDetailModel.releaseDate ??
                                        "2023-09-08"))));
                  },
                  child: Container(
                    height: 52,
                    width: MediaQuery.of(context).size.width * 0.86,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: lightBlue),
                    child: const Center(
                      child: Text(
                        "Select Seats",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
