import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';

class QButtomWidget extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color? color;
  final double? width;

  const QButtomWidget({
    required this.label,
    required this.onPressed,
    this.color,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? deviceWidth,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () => onPressed(),
        child: Text(
          label,
          style: styleTitle.copyWith(
            fontSize: setFontSize(50),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
