import 'package:flutter/material.dart' hide Form;

import '../components/button.dart';
import '../components/footer.dart';
import '../components/form.dart';
import '../icon_gallery.dart';
import '../localization.dart';
import '../panel.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = localization(context);
    const placeHolder = Placeholder();

    return Panel(
      icon: IconGallery.settings,
      title: l10n.settings_title,
      content: Form(
        title: intOf((_) => _.settings_title),
        fields: [
          FieldData(intOf((_) => _.settings_email), placeHolder),
          FieldData(
              intOf((_) => _.settings_name), placeHolder, (_) => placeHolder),
          FieldData(intOf((_) => _.settings_unit_system), placeHolder,
              (_) => placeHolder)
        ],
      ),
      footer: Footer(
        children: [
          Button(title: l10n.settings_logout),
          Button(title: l10n.settings_apply)
        ],
      ),
    );
  }
}
