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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
              Modular.to.pop();
            },
            icon: const Icon(Icons.chevron_left),
          ),
          IconButton(
            onPressed: onToogle,
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onToogle,
                icon: const Icon(Icons.zoom_out),
              ),
              IconButton(
                onPressed: onToogle,
                icon: const Icon(Icons.zoom_in),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onToogle,
                    icon: const Icon(Icons.arrow_circle_up_outlined),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onToogle,
                    icon: const Icon(Icons.arrow_circle_left_outlined),
                  ),
                  IconButton(
                    onPressed: onToogle,
                    icon: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onToogle,
                    icon: const Icon(Icons.arrow_circle_down_outlined),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
