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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FilledButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
              Modular.to.pop();
            },
            child: const Text('< Back'),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 100,
            child: FilledButton(
                onPressed: onToogle,
                child: Text('${isVisible ? 'Hide' : 'Show'} info')),
          ),
          const SizedBox(
            width: 20,
          ),
          const Chip(
              label: Padding(
            padding: EdgeInsets.all(3.0),
            child: Icon(
              Icons.pinch,
            ),
          ))
        ],
      ),
    );
  }
}
