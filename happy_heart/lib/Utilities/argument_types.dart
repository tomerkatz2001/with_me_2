import 'package:happy_heart/header.dart';
class EquipmentTypeArguments {
  final String name;
  EquipmentTypeArguments(this.name);
}
class EquipmentArguments {
  final MedicalEquipment equipment;
  final Function setStateParent;
  EquipmentArguments(this.equipment, this.setStateParent);
}