import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TextMessage extends StatelessWidget {
  final String lottie;
  final String message;
  final Function()? onPressed;
  const TextMessage({
    super.key,
    required this.lottie,
    required this.message,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottie,
            height: 150,
            width: 150,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 8,
          ),
          if (onPressed != null)
            ElevatedButton(
              onPressed: onPressed,
              child: const Text(
                'Refresh',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
