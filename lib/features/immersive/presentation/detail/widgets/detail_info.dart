import 'package:flutter/material.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/detail/widgets/detail_info_actions.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/detail/widgets/detail_info_explanation.dart';

class DetailInfo extends StatefulWidget {
  const DetailInfo({
    super.key,
    required this.title,
    required this.explanation,
  });

  final String title;
  final String explanation;

  @override
  State<DetailInfo> createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /*     Align(
          alignment: Alignment.topLeft,
          child: DetailInfoActions(
            onToogle: () => setState(() {
              _showInfo = !_showInfo;
            }),
            isVisible: _showInfo,
          ),
        ), */
        Align(
          alignment: Alignment.bottomLeft,
          child: DetailInfoExplanation(widget.explanation),
        ),
      ],
    );
  }
}
