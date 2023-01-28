import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jevahan/AllScreens/community.dart';
import 'package:jevahan/utilities/profile_background.dart';

import 'dart:math' as math;

import 'package:jevahan/utilities/stat.dart';

class GuideScreen extends StatefulWidget {
  static const String idScreen = "guidescreen";
  const GuideScreen({Key? key}) : super(key: key);

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  String _selectedTab = 'photos';

  _changeTab(String tab) {
    setState(() => _selectedTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    return ProfileBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 227, 167),
          title: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 15, 15, 15),
            ),
            onPressed: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, CommunityScreen.idScreen, (route) => false),
            },
          ),
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: math.pi / 4,
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: ProfileImageClipper(),
                    child: Image.asset(
                      'images/user.png',
                      width: 180.0,
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Text(
                'Lors Kome',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4.0),
              Text(
                '+91 XXX-XXXX-XXXX',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 80.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Stat(
                      title: 'Rating',
                      value: 9,
                    ),
                    Stat(
                      title: 'Speaks',
                      value: 2,
                    ),
                    Stat(
                      title: 'Distance \nfrom you',
                      value: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _changeTab('photos'),
                    child: SvgPicture.asset(
                      'assets/icons/Button-photos.svg',
                      color: _selectedTab == 'photos'
                          ? Color.fromARGB(255, 190, 247, 152)
                          : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changeTab('saved'),
                    child: SvgPicture.asset(
                      'assets/icons/Button-saved.svg',
                      color: _selectedTab == 'saved'
                          ? Color.fromARGB(255, 190, 247, 152)
                          : null,
                    ),
                  ),
                ],
              ),
              // we'll use flutter_staggered_grid_view package here:
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14.0,
                  crossAxisSpacing: 14.0,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.asset(
                          'images/frame-1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.asset(
                          'images/frame-2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.asset(
                          'images/frame-3.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.asset(
                          'images/frame-4.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImageClipper extends CustomClipper<Path> {
  double radius = 35;

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width / 2 - radius, radius)
      ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + radius, radius)
      ..lineTo(size.width - radius, size.height / 2 - radius)
      ..quadraticBezierTo(size.width, size.height / 2, size.width - radius,
          size.height / 2 + radius)
      ..lineTo(size.width / 2 + radius, size.height - radius)
      ..quadraticBezierTo(size.width / 2, size.height, size.width / 2 - radius,
          size.height - radius)
      ..lineTo(radius, size.height / 2 + radius)
      ..quadraticBezierTo(0, size.height / 2, radius, size.height / 2 - radius)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
