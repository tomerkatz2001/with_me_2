import '../header.dart';

Widget Input(controller,   String text,
    {hideFlag = false, numericFlag = false, errorText, validFlag = true, rtl=true,double width=300, onChanged, onTap}) {
  return Container(
      width: width,
      child: TextField(
        textDirection: TextDirection.rtl,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        
        decoration:  InputDecoration(
            labelText: text,
            hintText: text,
            hintTextDirection: TextDirection.rtl,
            suffixIcon: Icon(Icons.text_fields_outlined),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      )
      // TextFormField(
      //   obscureText: hideFlag,
      //   keyboardType: numericFlag ? TextInputType.number : TextInputType.text,
      //   controller: controller,
      //   textDirection: rtl?TextDirection.rtl:TextDirection.ltr,
      //   textAlignVertical: TextAlignVertical.bottom,
      //   decoration: InputDecoration(
      //       border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(10.0),
      //       ),
      //       errorText: validFlag ? null : errorText,
      //       filled: true,
      //       hintStyle: const TextStyle(color: Colors.black),
      //       hintTextDirection: TextDirection.rtl,
      //       hintText: text ?? "Type in your text",
      //       fillColor: Colors.transparent),
      // )
  );
}