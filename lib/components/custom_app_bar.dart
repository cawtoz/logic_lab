import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset('assets/logo.jpg', width: 30, height: 30),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          color: Colors.white,
          height: 0.8,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Ajusta la altura del AppBar si es necesario
}
