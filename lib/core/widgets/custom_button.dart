import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.size,
      required this.redius,
      required this.color});

  final String text;
  final VoidCallback onPressed;
  final Size? size;
  final double redius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            fixedSize: MaterialStatePropertyAll(size),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(redius),
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(color),
          ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
