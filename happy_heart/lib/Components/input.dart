import '../header.dart';

Widget Input(controller, text,
    {hideFlag = false, numericFlag = false, errorText, validFlag = true, rtl=true,double width=300}) {
  return Container(
      width: width,
      child: TextFormField(
        obscureText: hideFlag,
        keyboardType: numericFlag ? TextInputType.number : TextInputType.text,
        controller: controller,
        textDirection: rtl?TextDirection.rtl:TextDirection.ltr,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: validFlag ? null : errorText,
            filled: true,
            hintStyle: const TextStyle(color: Colors.black),
            hintTextDirection: TextDirection.rtl,
            hintText: text ?? "Type in your text",
            fillColor: Colors.transparent),
      )
  );
}