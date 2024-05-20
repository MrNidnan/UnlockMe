import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/app_navigation_controller.dart'; // ignore_for_file: must_be_immutable

class AppNavigationScreen extends GetWidget<AppNavigationController> {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildAppNavigation(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: AppDecoration.fillOnSecondaryContainer,
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          screenTitle: "lbl_bienvenido_one".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_perfil_usuario".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_editar_perfil_one".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_contadorviaje".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_bienvenido3".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_login".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_escanear_qr".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_mapa".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_pantalla_reserva".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_pop_up_insert_qr".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_pop_up_bluetooth".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_contadorreserva".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_editar_perfil".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_register".tr,
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_recuperar_pwd".tr,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation() {
    return Container(
      decoration: AppDecoration.fillOnSecondaryContainer,
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "lbl_app_navigation".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.primary.withOpacity(1),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "msg_check_your_app_s".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appTheme.blueGray400,
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: theme.colorScheme.primary.withOpacity(1),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle({required String screenTitle}) {
    return Container(
      decoration: AppDecoration.fillOnSecondaryContainer,
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.primary.withOpacity(1),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: appTheme.blueGray400,
          )
        ],
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(String routeName) {
    Get.toNamed(routeName);
  }
}
