import 'package:app/icon_gallery.dart';
import 'package:flutter/material.dart';

import '../localization.dart';
import '../panel.dart';

class LayerPanel extends StatelessWidget {
  const LayerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = localization(context);
    final textTheme = Theme.of(context).textTheme;

    return Panel(
      icon: IconGallery.layers,
      title: l10n.layers_title,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.layers_background_maps_title,
            style: textTheme.titleMedium,
          ),
          _BackgroundList(),
          const SizedBox(
            height: 10,
          ),
          Text(
            l10n.layers_additional_maps_title,
            style: textTheme.titleMedium,
          ),
          _AdditionalList()
        ],
      ),
    );
  }
}

class _BackgroundList extends StatefulWidget {
  @override
  State<_BackgroundList> createState() {
    return _BackgroundListState();
  }
}

class _BackgroundListState extends State<_BackgroundList> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 120, child: Placeholder());
  }
}

class _AdditionalList extends StatefulWidget {
  @override
  State<_AdditionalList> createState() {
    return _AdditionalListState();
  }
}

class _AdditionalListState extends State<_AdditionalList> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      child: Placeholder(),
    );
  }
}
