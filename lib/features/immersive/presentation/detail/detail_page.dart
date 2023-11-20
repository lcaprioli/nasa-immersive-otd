import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/detail/widgets/detail_info.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/detail/widgets/detail_info_actions.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.immersive});
  final ImmersiveEntity immersive;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _showInfo = true;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          return true;
        },
        child: Scaffold(
            body: Row(
          children: [
            DetailInfoActions(
              onToogle: () => setState(() {
                _showInfo = !_showInfo;
              }),
              isVisible: _showInfo,
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: InteractiveViewer(
                      child: Image.memory(
                        Uint8List.fromList(widget.immersive.imageBytes),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _showInfo,
                    child: SafeArea(
                      child: DetailInfo(
                        title: widget.immersive.title,
                        explanation: widget.immersive.explanation,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
