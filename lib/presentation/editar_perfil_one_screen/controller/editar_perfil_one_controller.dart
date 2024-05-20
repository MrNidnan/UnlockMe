import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/editar_perfil_one_model.dart';

/// A controller class for the EditarPerfilOneScreen.
///
/// This class manages the state of the EditarPerfilOneScreen, including the
/// current editarPerfilOneModelObj
class EditarPerfilOneController extends GetxController {
  TextEditingController edittextController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController edittextoneController = TextEditingController();

  TextEditingController edittexttwoController = TextEditingController();

  TextEditingController edittextthreeController = TextEditingController();

  Rx<EditarPerfilOneModel> editarPerfilOneModelObj = EditarPerfilOneModel().obs;

  @override
  void onClose() {
    super.onClose();
    edittextController.dispose();
    emailController.dispose();
    edittextoneController.dispose();
    edittexttwoController.dispose();
    edittextthreeController.dispose();
  }
}
