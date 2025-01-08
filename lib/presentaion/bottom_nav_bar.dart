import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_assesment/presentaion/deshboard_home/deshboard_home.dart';
import 'package:tentwenty_assesment/presentaion/media_library_home/media_library_screen.dart';
import 'package:tentwenty_assesment/presentaion/more_home/more_screen.dart';
import 'package:tentwenty_assesment/presentaion/watch/watch_screen.dart';
import 'package:tentwenty_assesment/utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(
        index: currentIndex,
        alignment: Alignment.bottomCenter,
        children: const [
          DashboardHome(),
          MovieScreen(),
          MediaLibraryScreen(),
          MoreScreen(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        child: BottomNavigationBar(
          selectedFontSize: 10,
          backgroundColor: gunmetal,
          selectedItemColor: whiteColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/deshboard.svg",
                ),
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/media.svg",
                ),
              ),
              label: "Watch",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/library.svg",
                ),
              ),
              label: "Media Library",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/more.svg",
                ),
              ),
              label: "More",
            ),
          ],
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
