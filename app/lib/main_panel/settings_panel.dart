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

    const footerDivisor = SizedBox(
      width: 10,
    );
    return Panel(
      icon: IconGallery.settings,
      title: l10n.settings_title,
      content: Form(
        entries: [
          (l10n.settings_email, _email(theme)),
          (l10n.settings_name, _name(theme)),
          (l10n.settings_unit_system, _unitSystem(theme))
        ],
      ),
      footer: FormFooter(
        children: [
          Button(title: l10n.settings_logout),
          Button(title: l10n.settings_cancel),
          Button(title: l10n.settings_apply)
        ],
      ),
    );
  }

  Widget _email(ThemeData theme) {
    return const Placeholder();
  }

  Widget _name(ThemeData theme) {
    return const Placeholder();
  }

  Widget _unitSystem(ThemeData theme) {
    return const Placeholder();
  }
}
