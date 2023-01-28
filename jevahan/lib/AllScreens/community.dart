import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jevahan/AllScreens/mainScreen.dart';
import 'package:jevahan/AllScreens/profile_screen.dart';
import 'package:jevahan/utilities/background.dart';

class CommunityScreen extends StatefulWidget {
  static const String idScreen = "community";
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // firstly, we need to create a backround
    return Background(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 190, 149, 61),
          title: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.idScreen, (route) => false),
            },
          ),
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 29,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 2, 24, 24),
                child: Text(
                  'Travel Community',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                        height: 56.0,
                        width: 56.0,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 24.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.0,
                              offset: const Offset(0, 4),
                              color: Colors.grey.withOpacity(0.52),
                            ),
                          ],
                        ),
                        child: Icon(Icons.add)),
                    ...List.generate(
                      5,
                      (index) => Container(
                        height: 56.0,
                        width: 56.0,
                        margin: EdgeInsets.only(
                          left: 30.0,
                          right: index == 4 ? 30.0 : 0.0,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2.0, color: Colors.grey),
                          image: const DecorationImage(
                            image: AssetImage('images/iconmap.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.pushNamedAndRemoveUntil(
                          context, ProfileScreen.idScreen, (route) => false),
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 32.0,
                      ),
                      padding: const EdgeInsets.all(14.0),
                      height: size.height * 0.40,
                      width: size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 14.0,
                              color: Color.fromARGB(255, 121, 117, 117),
                              offset: Offset(
                                0,
                                0,
                              )),
                        ],
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage('images/building-${index + 1}.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    maxRadius: 16.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              ProfileScreen.idScreen,
                                              (route) => false);
                                        },
                                        child: Text(
                                          'Siya',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                        ),
                                      ),
                                      Text(
                                        '2 hrs ago',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: Color.fromARGB(
                                                    255, 17, 16, 16)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildPostStat(
                                context: context,
                                iconPath: '',
                                value: 'Like',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPostStat({
    required BuildContext context,
    required String iconPath,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.40),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage('images/applogo.png'),
            height: 50,
            width: 50,
          ),
          const SizedBox(width: 8.0),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
