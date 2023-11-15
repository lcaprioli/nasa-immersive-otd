import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.immersive});
  final ImmersiveEntity immersive;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
            body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                child: Image.memory(
                  Uint8List.fromList(widget.immersive.imageBytes ?? []),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: DetailPageInfo(
                title: widget.immersive.title,
                explanation: widget.immersive.explanation,
              ),
            ),
          ],
        )));
  }
}

class DetailPageInfo extends StatefulWidget {
  const DetailPageInfo({
    super.key,
    required this.title,
    required this.explanation,
  });

  final String title;
  final String explanation;

  @override
  State<DetailPageInfo> createState() => _DetailPageInfoState();
}

class _DetailPageInfoState extends State<DetailPageInfo> {
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
                  child: Container(
                    color: Colors.white.withOpacity(.8),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                Expanded(
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
                            child: const Text('< Back')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SizedBox(
                          width: 100,
                          child: FilledButton(
                              onPressed: () => setState(() {
                                    _showInfo = !_showInfo;
                                  }),
                              child:
                                  Text('${_showInfo ? 'Hide' : 'Show'} info')),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: Opacity(
              opacity: _showInfo ? 1 : 0,
              child: SizedBox(
                  height: 100,
                  child: ColoredBox(
                      color: Colors.white.withOpacity(.9),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                            child: Text(widget.explanation)),
                      ))),
            )),
      ],
    );
  }
}
