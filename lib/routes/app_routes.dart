import '../core/app_export.dart';
import '../presentation/bienvenido_one_screen/bienvenido_one_screen.dart';
import '../presentation/bienvenido_one_screen/binding/bienvenido_one_binding.dart';
import '../presentation/bienvenido_screen/bienvenido_screen.dart';
import '../presentation/bienvenido_screen/binding/bienvenido_binding.dart';
import '../presentation/contadorviaje_screen/binding/contadorviaje_binding.dart';
import '../presentation/contadorviaje_screen/contadorviaje_screen.dart';
import '../presentation/editar_perfil_one_screen/binding/editar_perfil_one_binding.dart';
import '../presentation/editar_perfil_one_screen/editar_perfil_one_screen.dart';
import '../presentation/editar_perfil_screen/binding/editar_perfil_binding.dart';
import '../presentation/editar_perfil_screen/editar_perfil_screen.dart';
import '../presentation/qr_scan_screen/binding/qr_scan_binding.dart';
import '../presentation/qr_scan_screen/qr_scan_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/mapa_screen/binding/mapa_binding.dart';
import '../presentation/mapa_screen/mapa_screen.dart';
import '../presentation/pantalla_reserva/binding/pantalla_reserva_binding.dart';
import '../presentation/pantalla_reserva/pantalla_reserva.dart';
import '../presentation/perfil_usuario_screen/binding/perfil_usuario_binding.dart';
import '../presentation/perfil_usuario_screen/perfil_usuario_screen.dart';
import '../presentation/qr_manual_screen/binding/qr_manual_binding.dart';
import '../presentation/qr_manual_screen/qr_manual_screen.dart';
import '../presentation/recuperar_pwd_screen/binding/recuperar_pwd_binding.dart';
import '../presentation/recuperar_pwd_screen/recuperar_pwd_screen.dart';
import '../presentation/register_screen/binding/register_binding.dart';
import '../presentation/register_screen/register_screen.dart';

class AppRoutes {
  static const String bienvenidoOneScreen = '/bienvenido_one_screen';

  static const String perfilUsuarioScreen = '/perfil_usuario_screen';

  static const String editarPerfilOneScreen = '/editar_perfil_one_screen';

  static const String contadorViajeScreen = '/contadorviaje_screen';

  static const String bienvenidoScreen = '/bienvenido_screen';

  static const String loginScreen = '/login_screen';

  static const String qrScanScreen = '/qr_scan_screen';

  static const String qrManualScreen = '/qr_manual_screen';

  static const String mapaScreen = '/mapa_screen';

  static const String pantallaReserva = '/pantalla_reserva';

  static const String editarPerfilScreen = '/editar_perfil_screen';

  static const String registerScreen = '/register_screen';

  static const String recuperarPwdScreen = '/recuperar_pwd_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: bienvenidoOneScreen,
      page: () => const BienvenidoOneScreen(),
      bindings: [BienvenidoOneBinding()],
    ),
    GetPage(
      name: perfilUsuarioScreen,
      page: () => const PerfilUsuarioScreen(),
      bindings: [PerfilUsuarioBinding()],
    ),
    GetPage(
      name: editarPerfilOneScreen,
      page: () => const EditarPerfilOneScreen(),
      bindings: [EditarPerfilOneBinding()],
    ),
    GetPage(
      name: contadorViajeScreen,
      page: () => const ContadorviajeScreen(),
      bindings: [ContadorviajeBinding()],
    ),
    GetPage(
      name: bienvenidoScreen,
      page: () => const BienvenidoScreen(),
      bindings: [BienvenidoBinding()],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: qrScanScreen,
      page: () => const QrScanScreen(),
      bindings: [QrScanBinding()],
    ),
    GetPage(
      name: mapaScreen,
      page: () => const MapaScreen(),
      bindings: [MapaBinding()],
    ),
    GetPage(
      name: pantallaReserva,
      page: () => const PantallaReserva(),
      bindings: [PantallaReservaBinding()],
    ),
    GetPage(
      name: qrManualScreen,
      page: () => const QrManualScreen(),
      bindings: [QrManualBinding()],
    ),
    GetPage(
      name: editarPerfilScreen,
      page: () => const EditarPerfilScreen(),
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
      name: initialRoute,
      page: () => const BienvenidoOneScreen(),
      bindings: [BienvenidoOneBinding()],
    )
  ];
}
