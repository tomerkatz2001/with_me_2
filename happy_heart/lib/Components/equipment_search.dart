import 'package:happy_heart/header.dart';

class EquipmentSearch extends StatefulWidget {
  const EquipmentSearch({Key? key, this.text = 'חיפוש', this.onTap})
      : super(key: key);

  final String text;
  final void Function(MedicalEquipment)? onTap;

  @override
  State<EquipmentSearch> createState() => _EquipmentSearch();
}

class _EquipmentSearch extends State<EquipmentSearch> {
  TextEditingController editingController = TextEditingController();
  final ValueNotifier<List> _equipment = ValueNotifier<List>([]);
  List duplicateItems = [];
  String? chosenType;
  MedicalEquipment? chosenEquipment;

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List dummyListData = [];
      dummySearchList.forEach((item) {
        Map dict = getTypesMapFromEquipmentList([item]);
        if (dict.keys.elementAt(0).toString().contains(query)) {
          dummyListData.add(item);
        }
      });
      _equipment.value = dummyListData;
      return;
    } else {
      _equipment.value = duplicateItems; // restore the full list
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (chosenEquipment == null)
            ? Input(editingController, widget.text, onChanged: (value) {
                filterSearchResults(value);
                chosenType = null;
              }, onTap: () {
                filterSearchResults(editingController.text);
              })
            : Text("המוצר הנבחר:",textDirection: TextDirection.rtl,),
        StreamBuilder(
          stream: DB.getEquipmentStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _equipment.value = snapshot.data!.docs;
              duplicateItems = snapshot.data!.docs;
              return ValueListenableBuilder(
                  valueListenable: _equipment,
                  builder:
                      (BuildContext context, List equipment, Widget? child) {
                    Map dict = getTypesMapFromEquipmentList(equipment);
                    return (chosenType == null)
                        ? ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                                  color: Colors.grey,
                                ),
                            itemCount: dict.entries.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var current = dict.keys.elementAt(index);
                              return Center(
                                  child: typeListTile(current,
                                      itemsCount: dict[current].length,
                                      showAccess: false,
                                      onTap: () {
                                editingController.text = current;
                                chosenType = current;
                                filterSearchResults(current);
                              }));
                            })
                        : (chosenEquipment == null)
                            ? ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                itemCount: dict[chosenType].length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      child: equipmentListTile(
                                          dict[chosenType][index],
                                          showAccess:false,
                                        showDatainDesc:true),
                                      onTap: () {
                                        if (widget.onTap != null)
                                          widget
                                              .onTap!(dict[chosenType][index]);
                                        chosenEquipment =
                                            dict[chosenType][index];
                                        setState(() {});
                                      });
                                })
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                itemCount: 1,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {

                                  return GestureDetector(child:Center(
                                      child: equipmentListTile(chosenEquipment!,
                                          showDatainDesc:true,
                                        showAccess: false
                                   )),
                                    onTap: (){
                                      setState(() {
                                        chosenEquipment=null;
                                      });
                                    },
                                  );
                                });
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    ));
  }
}
