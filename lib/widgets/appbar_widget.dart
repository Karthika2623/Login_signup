import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;
  final List<Widget>? action;
  final double? size;
  final bool? automaticallyImplyLeading;
  final int? initialIndex;
  const CustomAppBar({super.key, required this.text,this.onTap,this.action,this.automaticallyImplyLeading,this.size, this.icon, this.initialIndex});
  @override
  Widget build(BuildContext context) {
    double? sizes=size ?? 23.0;
    return
      AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          toolbarHeight: 100,
          title:  Text(
            text,
            style:  TextStyle(
                fontSize:sizes,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),
          ),
          leading:icon != null ? IconButton(
            icon: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ) : null,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0XFFB81736), Color(0XFF281537)],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
          ),
          actions: action
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
