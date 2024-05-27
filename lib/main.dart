import 'package:UnlockMe/core/storage/contracts/bike.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/app_export.dart';
import 'core/storage/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper();
  dbHelper.clearDatabase();
  dbHelper.populateWithFakeData();
  await Hive.initFlutter();

  // Fetch all users
  List<Map<String, dynamic>> users = await dbHelper.getUsers();
  Logger.logDebug(users);

  // Fetch all bikes
  List<Bike> bikes = await dbHelper.getBikes();
  bikes.forEach((bike) {
    Logger.logDebug('Bike ID: ${bike.id}, Status: ${bike.status}');
  });

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
