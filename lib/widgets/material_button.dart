import 'package:flutter/material.dart';
class MaterialButtonDesign extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final double? size;
  final Color? color1;
  final Color? color2;
  final bool? loading;
  final void Function() onTap;
  const MaterialButtonDesign({super.key, this.color1,this.color2,this.size,required this.height, required this.width, required this.text, required this.onTap, this.loading});

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = color1 != null && color2 != null
        ? [color1!, color2!]
        : [const Color(0XFFB81736), const Color(0XFF281537)];
    return  loading ?? false
        ? const Center(child: CircularProgressIndicator()) // Show CircularProgressIndicator when loading is true
        : Container(
      decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: gradientColors,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      child: MaterialButton(
        onPressed: onTap,
        height:height,
        minWidth: width,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child:  Text(
          text,
          textAlign: TextAlign.center,
          style:  TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: size ?? 16.0,
              color: Colors.white),
        ),
      ),
    );
  }
}
