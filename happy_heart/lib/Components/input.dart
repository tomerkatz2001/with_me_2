import '../header.dart';

Widget Input(controller, text,
    {hideFlag = false, numericFlag = false, errorText, validFlag = true}) {
  return Container(
      child: TextFormField(
        obscureText: hideFlag,
        keyboardType: numericFlag ? TextInputType.number : TextInputType.text,
        controller: controller,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: validFlag ? null : errorText,
            filled: true,
            hintStyle: const TextStyle(color: Colors.black),
            hintText: text ?? "Type in your text",
            fillColor: Colors.transparent),
      )
  );
}