import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final double? width;
  final void Function()? action;

  const Button({
    super.key,
    required this.title,
    this.width,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final container = Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(5),
      width: width,
      child: Center(
        child: Text(
          title,
          style: theme.textTheme.labelLarge
              ?.copyWith(color: theme.colorScheme.onPrimary),
        ),
      ),
    );

    return (action != null)
        ? GestureDetector(
            onTap: action,
            child: container,
          )
        : container;
  }
}
