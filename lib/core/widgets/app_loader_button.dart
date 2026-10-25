import 'package:flutter/material.dart';

class AppLoaderButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final IconData? icon;
  final VoidCallback? onPressed;

  const AppLoaderButton({
    super.key,
    required this.label,
    this.isLoading = false,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon),
                  const SizedBox(width: 8),
                ],
                Text(label),
              ],
            ),
    );
  }
}
