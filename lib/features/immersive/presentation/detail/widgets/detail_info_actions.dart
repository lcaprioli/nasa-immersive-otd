import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailInfoActions extends StatelessWidget {
  const DetailInfoActions({
    super.key,
    required this.onToogle,
    required this.isVisible,
  });

  final VoidCallback onToogle;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: FilledButton(
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);
                Modular.to.pop();
              },
              child: const Text('< Back'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
              width: 100,
              child: FilledButton(
                  onPressed: onToogle,
                  child: Text('${isVisible ? 'Hide' : 'Show'} info')),
            ),
          ),
        ],
      ),
    );
  }
}
