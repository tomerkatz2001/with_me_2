import '../header.dart';

class AddImageComponent extends StatefulWidget {
  const AddImageComponent({super.key, required this.updateImage});

  final Function updateImage;

  @override
  _AddImageComponentState createState() => _AddImageComponentState();
}

class _AddImageComponentState extends State<AddImageComponent> {
  var _image = null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _image == null ? Image.asset("no_image_available.jpg", height: 200, width: 200,) :
        Image.memory(_image, height: 200, width: 200,),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(onPressed: () async {
            ImagePicker picker = ImagePicker();
            XFile? image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              var imageBytes = await image.readAsBytes();
              setState(() {
                _image = imageBytes;
              });
              widget.updateImage(imageBytes);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No image selected"))
              );
            }
          }, icon: const Icon(Icons.camera_alt, color: Colors.amber,),
            tooltip: "הוסף תמונה",
          ),
        ),
      ],
    );
  }
}