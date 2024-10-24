import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zioks_application/token_provider.dart';
import 'pages/user_photo.dart';
import 'pages/opening_page.dart';
import 'pages/purposepage.dart';
import 'pages/detailspage.dart';
import 'pages/confirmation_page.dart';
import 'pages/CheckInPhone.dart';
import 'pages/checkInScanQR.dart';
import 'pages/checkOut.dart';
import 'pages/visitor_info.dart';
import 'routes.dart';
import 'pages/company_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context){
        return TokenProvider();
      },
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        themeMode: ThemeMode.light,
        home: OpeningPage(),
        initialRoute: MyRoutes.openingpageRoute,
        routes: {
          MyRoutes.openingpageRoute: (context) => OpeningPage(),
          MyRoutes.CheckInPhoneRoute: (context) => PhoneNumber(),
          MyRoutes.checkOutRoute: (context) => Checkout(),
          MyRoutes.deatilspageRoute: (context) => Details(),
          MyRoutes.purposepageRoute: (context) => Purpose(),
          MyRoutes.userphotoRoute: (context) => UserPhoto(),
          MyRoutes.companySearchRoute: (context) => CompanySearch(),
        },
      ),
    );
  }
}
