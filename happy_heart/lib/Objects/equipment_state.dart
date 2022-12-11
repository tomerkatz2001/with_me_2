import 'package:happy_heart/header.dart';

enum EquipmentState{
  USED,
  NEW,
  LIKE_NEW,
  SLIGHTLY_USED
}
extension EquipmentStateName on EquipmentState{
  String get name {
    switch(this){
      case EquipmentState.SLIGHTLY_USED:
        return "מעט משומש";
      case EquipmentState.USED:
        return "משומש";
      case EquipmentState.NEW:
        return "חדש";
      case EquipmentState.LIKE_NEW:
        return "כמו חדש";
    }
  }
}
EquipmentState stateFromTitle(String title){
  switch(title){
    case "מעט משומש":
      return EquipmentState.SLIGHTLY_USED;
    case "משומש":
      return EquipmentState.USED;
    case "חדש":
      return EquipmentState.NEW;
    case "כמו חדש":
      return EquipmentState.LIKE_NEW;
    default:
      return EquipmentState.NEW;
  }
}