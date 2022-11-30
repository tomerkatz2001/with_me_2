import '../header.dart';

class TappableText extends StatelessWidget {
  var text;
  var onTapFunc;
  var style;
  var contextFlag;
  var data;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: style ?? const TextStyle(color: Colors.white),
          recognizer: TapGestureRecognizer()
            ..onTap = contextFlag != null
                ? () => onTapFunc(context)
                : () => onTapFunc()),
    );
  }

  TappableText(this.text, this.onTapFunc,
      {TextStyle? this.style, bool? this.contextFlag, this.data});
}

class TappableTextWithData extends StatelessWidget {
  var text;
  var onTapFunc;
  var style;
  var contextFlag;
  var data;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: style ?? const TextStyle(color: Colors.white),
          recognizer: TapGestureRecognizer()
            ..onTap = contextFlag != null
                ? () => onTapFunc(context, data)
                : () => onTapFunc()),
    );
  }

  TappableTextWithData(this.text, this.onTapFunc,
      {TextStyle? this.style, bool? this.contextFlag, this.data});
}