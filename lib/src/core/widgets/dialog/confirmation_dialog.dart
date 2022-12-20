import 'package:flutter/material.dart';

import '../../configs/app_configs.dart';

/// {@template confirmation_dialog}
/// A dialog with title, subtitle and  two button with text yes and no
/// respectively.
/// {@endtemplate}
class ConfirmationDialog extends StatelessWidget {
  /// {@macro confirmation_dialog}
  const ConfirmationDialog({
    Key? key,
    required this.title,
    this.subtitle,
    this.yesText,
    this.noText,
  }) : super(key: key);

  /// the title of the dialog
  final String title;

  /// a short description for the purpose of the dialog
  final String? subtitle;

  /// text of yes button
  final String? yesText;

  /// text of no button
  final String? noText;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        if (subtitle != null) Text(subtitle!),
        ButtonBar(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(yesText ?? localization.yes),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(noText ?? localization.no),
            ),
          ],
        )
      ],
    );
  }

  /// Show this dialog
  Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => this,
    );

    return result ?? false;
  }
}
