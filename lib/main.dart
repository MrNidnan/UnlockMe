import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'core/storage/database_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper();

  // Insert a fake user
  await dbHelper.insertUser({
    'name': 'Angel',
    'lastname': 'Test',
    'email': 'angel@test.com',
    'password': '123',
    'hotelId': 1,
  });

  // Insert a couple of bikes with coordinates from Barcelona
  await dbHelper.insertBike({
    'latitude': 41.3851,
    'longitude': 2.1734,
    'battery_life': 85,
    'hotelId': 1,
    'status': 'free',
  });

  await dbHelper.insertBike({
    'latitude': 41.3879,
    'longitude': 2.1699,
    'battery_life': 90,
    'hotelId': 2,
    'status': 'free',
  });

  // Fetch all users
  List<Map<String, dynamic>> users = await dbHelper.getUsers();
  print(users);

  // Fetch all bikes
  List<Map<String, dynamic>> bikes = await dbHelper.getBikes();
  print(bikes);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        translations: AppLocalization(),
        locale: Get.deviceLocale,
        fallbackLocale: Locale('en', 'US'),
        title: 'UnlockMe',
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
      );
    });
  }
}
