import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_peddiehacks/constants/constants.dart';
import 'package:flutter_peddiehacks/screens/teacher/school/create_new_school_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_peddiehacks/services/APIServices.dart';
import 'package:flutter_peddiehacks/widgets/custom_button.dart';
import 'package:flutter_peddiehacks/widgets/page_banner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({Key? key}) : super(key: key);

  @override
  _SchoolPageState createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  String school = '';

  Future<Map<String, dynamic>> _retrieveInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    school = await prefs.getString('school')!;
    var response = await context.read<APIServices>().retrieveSchoolInfo();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _retrieveInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
            return Column(
              children: [
                PageBanner(text: 'School Info'),
                SizedBox(height: 2 * kDefaultPadding),
                Text(
                  data['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                Text(
                  data['city'],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 0.7 * kDefaultPadding),
                Text(
                  data['address'],
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildInfoBubble(
                      context,
                      'Weapons',
                      'https://patch.com/new-jersey/hillsborough/montgomery-man-jailed-chasing-woman-kids-fake-gun-cops',
                    ),
                    SizedBox(width: 0.1 * MediaQuery.of(context).size.width),
                    _buildInfoBubble(
                      context,
                      'Drugs',
                      'https://dailyvoice.com/new-jersey/somerset/police-fire/busted-31-nabbed-14-pounds-of-coke-firearms-seized-in-massive-drug-distribution-scheme/812725/',
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildInfoBubble(
                      context,
                      'Assault',
                      'https://dailyvoice.com/new-jersey/burlington/police-fire/dangerous-south-jersey-fugitive-nabbed-after-assaulting-us-marshals-in-philadelphia/802388/',
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNewSchoolPage(),
                    ),
                  ),
                  child: CustomButton(
                    purpose: 'other',
                    text: 'CREATE NEW',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Container _buildInfoBubble(BuildContext context, String keyword, String url) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      width: 0.35 * MediaQuery.of(context).size.width,
      height: 0.35 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15.0,
            spreadRadius: 0.0,
            color: kPrimaryColor.withOpacity(0.2),
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: () => _launchUrl(context, url),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                keyword,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.0),
              Transform.rotate(
                angle: 180 * math.pi / 180,
                child: Icon(
                  Icons.arrow_back,
                  size: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Error launching url');
    }
  }
}
