import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_assesment/utils/colors.dart';
import 'package:tentwenty_assesment/utils/helper_function.dart';

class BookSeat extends StatefulWidget {
  final String movieName;
  final String releaseDate;

  const BookSeat(
      {super.key, required this.movieName, required this.releaseDate});

  @override
  State<BookSeat> createState() => _BookSeatState();
}

class _BookSeatState extends State<BookSeat> {
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
                  fontSize: 16, color: blackColor, fontWeight: FontWeight.bold),
            ),
            Text(
              "In Theaters ${widget.releaseDate}",
              style: createCustomTextStyle(
                  fontSize: 16, color: lightBlue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Set the height of the divider
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(child: SvgPicture.asset("assets/book.svg")),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: whiteColor,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: whiteColor,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          hDivider(),
          Container(
            color: whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/Seat.svg",
                          height: 30, color: fontColor),
                      const SizedBox(width: 8),
                      Text("Regular",
                          style: createCustomTextStyle(color: fontColor)),
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset("assets/Seat.svg",
                          height: 30, color: yellow),
                      const SizedBox(width: 8),
                      Text("VIP",
                          style: createCustomTextStyle(color: fontColor)),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/Seat.svg",
                          height: 30, color: lightBlue),
                      const SizedBox(width: 8),
                      Text("Regular",
                          style: createCustomTextStyle(color: fontColor)),
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset("assets/Seat.svg",
                          height: 30, color: blue),
                      const SizedBox(width: 8),
                      Text("Regular",
                          style: createCustomTextStyle(color: fontColor)),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xffF6F6FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "4/3 row",
                          style: createCustomTextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          "assets/remove.svg",
                          height: 15,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F6FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 6),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Total price",
                                style: createCustomTextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                ),
                              ),
                              Text(
                                "\$ 50",
                                style: createCustomTextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: lightBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Proceed to pay",
                                  style: createCustomTextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
