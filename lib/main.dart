import 'package:UnlockMe/core/services/hive_service.dart';
import 'package:UnlockMe/core/services/travel_timer_service.dart';
import 'package:UnlockMe/core/storage/contracts/bike.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'core/storage/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Logger
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);

    // Initialize DatabaseHelper
    final dbHelper = DatabaseHelper();
    await dbHelper.clearDatabase();
    await dbHelper.populateWithFakeData();

    // Register and Initialize Hive
    await Get.putAsync(() => HiveService().initializeHive());

    // Fetch all users
    List<Map<String, dynamic>> users = await dbHelper.getUsers();
    Logger.logDebug(users);

    // Fetch all bikes
    List<Bike> bikes = await dbHelper.getBikes();
    bikes.forEach((bike) {
      Logger.logDebug('Bike ID: ${bike.id}, Status: ${bike.status}');
    });

    // Register TimerServiceS as a singleton
    Get.put(ReserveTimerService());
    Get.put(TravelTimerService());

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) {
      Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
      runApp(MyApp());
    });
  } catch (e, stackTrace) {
    Logger.logError('Error during initialization: $e\n$stackTrace');
  }
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
