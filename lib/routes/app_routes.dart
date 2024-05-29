import '../core/app_export.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/bienvenido_one_screen/bienvenido_one_screen.dart';
import '../presentation/bienvenido_one_screen/binding/bienvenido_one_binding.dart';
import '../presentation/bienvenido_screen/bienvenido_screen.dart';
import '../presentation/bienvenido_screen/binding/bienvenido_binding.dart';
import '../presentation/contadorreserva_screen/binding/contadorreserva_binding.dart';
import '../presentation/contadorreserva_screen/contadorreserva_screen.dart';
import '../presentation/contadorviaje_screen/binding/contadorviaje_binding.dart';
import '../presentation/contadorviaje_screen/contadorviaje_screen.dart';
import '../presentation/editar_perfil_one_screen/binding/editar_perfil_one_binding.dart';
import '../presentation/editar_perfil_one_screen/editar_perfil_one_screen.dart';
import '../presentation/editar_perfil_screen/binding/editar_perfil_binding.dart';
import '../presentation/editar_perfil_screen/editar_perfil_screen.dart';
import '../presentation/escanear_qr_screen/binding/escanear_qr_binding.dart';
import '../presentation/escanear_qr_screen/escanear_qr_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/mapa_screen/binding/mapa_binding.dart';
import '../presentation/mapa_screen/mapa_screen.dart';
import '../presentation/pantalla_reserva/binding/pantalla_reserva_binding.dart';
import '../presentation/pantalla_reserva/pantalla_reserva.dart';
import '../presentation/perfil_usuario_screen/binding/perfil_usuario_binding.dart';
import '../presentation/perfil_usuario_screen/perfil_usuario_screen.dart';
import '../presentation/pop_up_bluetooth_out_of_range_screen/binding/pop_up_bluetooth_out_of_range_binding.dart';
import '../presentation/pop_up_bluetooth_out_of_range_screen/pop_up_bluetooth_out_of_range_screen.dart';
import '../presentation/pop_up_insert_qr_code_screen/binding/pop_up_insert_qr_code_binding.dart';
import '../presentation/pop_up_insert_qr_code_screen/pop_up_insert_qr_code_screen.dart';
import '../presentation/recuperar_pwd_screen/binding/recuperar_pwd_binding.dart';
import '../presentation/recuperar_pwd_screen/recuperar_pwd_screen.dart';
import '../presentation/register_screen/binding/register_binding.dart';
import '../presentation/register_screen/register_screen.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String bienvenidoOneScreen = '/bienvenido_one_screen';

  static const String perfilUsuarioScreen = '/perfil_usuario_screen';

  static const String editarPerfilOneScreen = '/editar_perfil_one_screen';

  static const String contadorViajeScreen = '/contadorviaje_screen';

  static const String bienvenidoScreen = '/bienvenido_screen';

  static const String loginScreen = '/login_screen';

  static const String escanearQrScreen = '/escanear_qr_screen';

  static const String mapaScreen = '/mapa_screen';

  static const String pantallaReserva = '/pantalla_reserva';

  static const String popUpInsertQrCodeScreen = '/pop_up_insert_qr_code_screen';

  static const String popUpBluetoothOutOfRangeScreen =
      '/pop_up_bluetooth_out_of_range_screen';

  static const String contadorreservaScreen = '/contadorreserva_screen';

  static const String editarPerfilScreen = '/editar_perfil_screen';

  static const String registerScreen = '/register_screen';

  static const String recuperarPwdScreen = '/recuperar_pwd_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: bienvenidoOneScreen,
      page: () => BienvenidoOneScreen(),
      bindings: [BienvenidoOneBinding()],
    ),
    GetPage(
      name: perfilUsuarioScreen,
      page: () => PerfilUsuarioScreen(),
      bindings: [PerfilUsuarioBinding()],
    ),
    GetPage(
      name: editarPerfilOneScreen,
      page: () => EditarPerfilOneScreen(),
      bindings: [EditarPerfilOneBinding()],
    ),
    GetPage(
      name: contadorViajeScreen,
      page: () => ContadorviajeScreen(),
      bindings: [ContadorviajeBinding()],
    ),
    GetPage(
      name: bienvenidoScreen,
      page: () => BienvenidoScreen(),
      bindings: [BienvenidoBinding()],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: escanearQrScreen,
      page: () => EscanearQrScreen(),
      bindings: [EscanearQrBinding()],
    ),
    GetPage(
      name: mapaScreen,
      page: () => MapaScreen(),
      bindings: [MapaBinding()],
    ),
    GetPage(
      name: pantallaReserva,
      page: () => PantallaReserva(),
      bindings: [PantallaReservaBinding()],
    ),
    GetPage(
      name: popUpInsertQrCodeScreen,
      page: () => PopUpInsertQrCodeScreen(),
      bindings: [PopUpInsertQrCodeBinding()],
    ),
    GetPage(
      name: popUpBluetoothOutOfRangeScreen,
      page: () => PopUpBluetoothOutOfRangeScreen(),
      bindings: [PopUpBluetoothOutOfRangeBinding()],
    ),
    GetPage(
      name: contadorreservaScreen,
      page: () => ContadorreservaScreen(),
      bindings: [ContadorreservaBinding()],
    ),
    GetPage(
      name: editarPerfilScreen,
      page: () => EditarPerfilScreen(),
      bindings: [EditarPerfilBinding()],
    ),
    GetPage(
      name: registerScreen,
      page: () => RegisterScreen(),
      bindings: [RegisterBinding()],
    ),
    GetPage(
      name: recuperarPwdScreen,
      page: () => RecuperarPwdScreen(),
      bindings: [RecuperarPwdBinding()],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: initialRoute,
      page: () => BienvenidoOneScreen(),
      bindings: [BienvenidoOneBinding()],
    )
  ];
}
