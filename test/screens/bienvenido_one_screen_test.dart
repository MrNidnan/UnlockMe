import 'package:UnlockMe/presentation/bienvenido_one_screen/bienvenido_one_screen.dart';
import 'package:UnlockMe/presentation/bienvenido_one_screen/controller/bienvenido_one_controller.dart';
import 'package:UnlockMe/presentation/bienvenido_one_screen/models/bienvenido_one_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:UnlockMe/routes/app_routes.dart';

class MockBienvenidoOneController extends GetxController
    implements BienvenidoOneController {
  @override
  late Rx<BienvenidoOneModel> bienvenidoOneModelObj;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBienvenidoOneController mockController;

  setUp(() {
    mockController = MockBienvenidoOneController();
    Get.put(mockController);
  });

  testWidgets('BienvenidoOneScreen has an Empezar button and navigates on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => const BienvenidoOneScreen(),
          ),
          GetPage(
            name: AppRoutes.bienvenidoScreen,
            page: () =>
                Scaffold(body: Center(child: Text('Bienvenido Screen'))),
          ),
        ],
      ),
    );

    // Ensure the BienvenidoOneScreen is displayed
    expect(find.byType(BienvenidoOneScreen), findsOneWidget);

    // Find the Empezar button
    final empezarButton = find.text("lbl_empezar".tr);

    // Ensure the Empezar button is found
    expect(empezarButton, findsOneWidget);

    // Tap the Empezar button
    await tester.tap(empezarButton);
    await tester.pumpAndSettle();

    // Verify that the navigation to BienvenidoScreen occurred
    expect(find.text('Bienvenido Screen'), findsOneWidget);
  });
}
