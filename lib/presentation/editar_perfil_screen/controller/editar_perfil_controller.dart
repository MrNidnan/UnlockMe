import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/editar_perfil_model.dart';

/// A controller class for the EditarPerfilScreen.
///
/// This class manages the state of the EditarPerfilScreen, including the
/// current editarPerfilModelObj
class EditarPerfilController extends GetxController {
  TextEditingController editprofileoneController = TextEditingController();

  TextEditingController englishoneController = TextEditingController();

  Rx<EditarPerfilModel> editarPerfilModelObj = EditarPerfilModel().obs;

  @override
  void onClose() {
    super.onClose();
    editprofileoneController.dispose();
    englishoneController.dispose();
  }
}
