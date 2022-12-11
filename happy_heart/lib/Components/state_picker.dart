import 'package:happy_heart/header.dart';
Widget StatePicker(MedicalEquipment equipment,Function notifyParent){
  return DropdownButton<EquipmentState>(
      value: equipment.state,
      onChanged: (EquipmentState? newValue) {
        if(newValue!=null) {
          equipment.state = newValue;
        } else{
          equipment.state = EquipmentState.NEW;
          notifyParent();
        }
      },
      items: EquipmentState.values.map((EquipmentState state) {
        return DropdownMenuItem<EquipmentState>(
            value: state,
            child: Text(state.name));
      }).toList()
  );
}