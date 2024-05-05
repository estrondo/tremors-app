import 'package:flutter/material.dart' hide Form;

import '../components/button.dart';
import '../components/form.dart';
import '../icon_gallery.dart';
import '../localization.dart';
import '../panel.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = localization(context);
    final theme = Theme.of(context);

    const placeHolder = Placeholder();

    return Panel(
      icon: IconGallery.settings,
      title: l10n.settings_title,
      content: Form(
        title: l10n.settings_title,
        entries: [
          FormEntry(l10n.settings_email, placeHolder),
          FormEntry(l10n.settings_name, placeHolder, placeHolder),
          FormEntry(l10n.settings_unit_system, placeHolder, placeHolder)
        ],
      ),
      footer: FormFooter(
        children: [
          Button(title: l10n.settings_logout),
          Button(title: l10n.settings_apply)
        ],
      ),
    );
  }
}
