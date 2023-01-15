
import 'package:flutter/rendering.dart';

import '../header.dart';

class EquipmentPage extends StatefulWidget {
  EquipmentArguments arguments;
  EquipmentPage(this.arguments, {super.key});
  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {

  late int editableFieldIdx;
  @override
  void initState() {
    super.initState();
    editableFieldIdx = -1;
  }

  @override
  Widget build(BuildContext context) {

    MedicalEquipment equipment = widget.arguments.equipment;

    if(!equipment.fields.keys.contains("image")){
      equipment.fields["image"] = "/images/no_image_available.jpg";
    }

    List<MapEntry<String,dynamic>> fieldsList = equipment.fields.entries.toList();
    fieldsList.sort((a, b) => a.key == "image" ? -1 : b.key == "image" ? 1 : 0);



    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          color: Colors.white,
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalSpacer(10),
                          ListView.builder(
                              itemCount: fieldsList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                var current = fieldsList[index];
                                if(current.key!="available") {
                                  return Center(
                                      child: current.key == "image" ? _buildImageWidget(current)
                                          :index == editableFieldIdx ? editInputField(TextEditingController(), current.key, current.value)
                                          : fieldsListTile(current, onTap: ()=>setState(() {
                                            editableFieldIdx = index;
                                          })));
                                }else{
                                  return Container();
                                }
                              })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildImageWidget(MapEntry<String, dynamic> current) => FutureBuilder(
      future: DB.downloadImage(current.value),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if(snapshot.hasData){
          return Stack(children:
          [
            SizedBox(width: 200, height: 200,child: Image.network(snapshot.data!),),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(onPressed: () async {
                ImagePicker picker = ImagePicker();
                XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  await DB.uploadImage(await image.readAsBytes(), currentPath : current.value);
                  setState(() {});
                  widget.arguments.setStateParent();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No image selected"))
                  );
                }
              }, icon: const Icon(Icons.camera_alt, color: Colors.amber,),
                tooltip: "שנה תמונה",
              ),
            ),
          ]);
        }else{
          return const CircularProgressIndicator();
        }
      });
}
