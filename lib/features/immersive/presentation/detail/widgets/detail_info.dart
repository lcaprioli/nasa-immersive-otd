import 'package:flutter/material.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/detail/widgets/detail_info_actions.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/detail/widgets/detail_info_explanation.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/detail/widgets/detail_info_title.dart';

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
  bool _showInfo = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: _showInfo ? 1 : 0,
                  child: DetailInfoTitle(widget.title),
                ),
                DetailInfoActions(
                  onToogle: () => setState(() {
                    _showInfo = !_showInfo;
                  }),
                  isVisible: _showInfo,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: _showInfo ? 1 : 0,
            child: DetailInfoExplanation(widget.explanation),
          ),
        ),
      ],
    );
  }
}
