import 'package:UnlockMe/core/services/hive_service.dart';
import 'package:UnlockMe/data/models/loginDeviceAuth/post_login_device_auth_resp.dart';
import 'package:UnlockMe/core/storage/contracts/user.dart';
import 'package:UnlockMe/core/storage/database_helper.dart';
import 'package:UnlockMe/presentation/login_screen/controller/login_controller.dart';
import 'package:UnlockMe/presentation/login_screen/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockHiveService extends Mock implements HiveService {}

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

class MockUser extends Mock implements User {}

//class MockLogger extends Mock implements Logger {}

void main() {
  late LoginController loginController;
  late MockHiveService mockHiveService;
  late MockDatabaseHelper mockDatabaseHelper;
  //late MockLogger mockLogger;

  setUp(() {
    mockHiveService = MockHiveService();
    mockDatabaseHelper = MockDatabaseHelper();
    //mockLogger = MockLogger();
    Get.put<HiveService>(mockHiveService);
    loginController = LoginController();
    loginController.onInit();
  });

  tearDown(() {
    loginController.onClose();
    Get.reset();
  });

  group('LoginController Test', () {
    test('Initial values are correct', () {
      expect(loginController.emailController, isA<TextEditingController>());
      expect(loginController.eyeController, isA<TextEditingController>());
      expect(loginController.loginModelObj.value, isA<LoginModel>());
      expect(loginController.isShowPassword.value, true);
      expect(loginController.recordarMisDato.value, false);
      expect(loginController.reply.value, false);
    });

    test('Should dispose controllers on close', () {
      loginController.onClose();
      expect(() => loginController.emailController.text,
          throwsA(isA<FlutterError>()));
      expect(() => loginController.eyeController.text,
          throwsA(isA<FlutterError>()));
    });

    test('Should call _onCallAuthSuccess on valid user', () async {
      final mockUser = MockUser();
      when(mockUser.password).thenReturn('password');
      when(mockUser.id).thenReturn(1);
      when(mockUser.hotelId).thenReturn(23);

      when(mockDatabaseHelper.getUser("test@test.com"))
          .thenAnswer((_) async => mockUser);
      when(mockHiveService.setUserId(1)).thenAnswer((_) async => {});
      when(mockHiveService.setHotelId(23)).thenAnswer((_) async => {});

      loginController.emailController.text = 'test@test.com';
      loginController.eyeController.text = 'password';

      await loginController.callAuthMock();

      verify(mockDatabaseHelper.getUser("test@test.com")).called(1);
      verify(mockHiveService.setUserId(1)).called(1);
      verify(mockHiveService.setHotelId(23)).called(1);
      // Add further verifications if needed
    });

    // test('Should call _onCallAuthError on invalid user', () async {
    //   when(mockDatabaseHelper.getUser("test@test.com"))
    //       .thenAnswer((_) async => null);
    //   loginController.emailController.text = 'test@test.com';
    //   loginController.eyeController.text = 'wrongpassword';

    //   await loginController.callAuthMock();

    //   //verify(mockLogger.logError('User not found')).called(1);
    //   //verify(mockSnackbarService.showSnackbar("Invalid password")).called(1);
    //   // Add further verifications if needed
    // });
  });
}
