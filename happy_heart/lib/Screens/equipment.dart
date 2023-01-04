
import '../header.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});
  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!(ModalRoute.of(context)!.settings.arguments is EquipmentArguments)){
      Navigator.of(context).pop();
    }
    final arguments =
        ModalRoute.of(context)!.settings.arguments as EquipmentArguments;
    MedicalEquipment equipment = arguments.equipment;

    if(!equipment.fields.keys.contains("image")){
      equipment.fields["image"] = "/images/no_image_available.jpg";
    }

    List<MapEntry<String,dynamic>> fieldsList = equipment.fields.entries.toList();
    fieldsList.sort((a, b) => a.key == "image" ? -1 : b.key == "image" ? 1 : 0);

    return Scaffold(
      appBar: StyledAppBar(context, equipment.type,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            VerticalSpacer(10),
            Expanded(child: ListView.builder(
                itemCount: fieldsList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var current = fieldsList[index];
                  if(current.key!="available") {
                    return Center(
                        child: current.key == "image" ? FutureBuilder(
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
                                        arguments.setStateParent();
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
                            })
                            : fieldsListTile(current));
                  }else{
                    return Container();
                  }
                }))
          ],
        ),
      ),
    );
  }
}
