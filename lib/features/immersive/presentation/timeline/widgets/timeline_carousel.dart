import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_date_navigation.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_item_content.dart';

class TimelineCarousel extends StatefulWidget {
  const TimelineCarousel(
    this.immersives, {
    super.key,
  });

  final Set<ImmersiveEntity> immersives;

  @override
  State<TimelineCarousel> createState() => _TimelineCarouselState();
}

class _TimelineCarouselState extends State<TimelineCarousel> {
  late PageController _controller;
  late int _actual;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _actual = widget.immersives.length - 1;
    _controller = PageController(initialPage: _actual);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TimelineCarousel oldWidget) {
    _actual = widget.immersives.length - 1;
    _controller = PageController(initialPage: _actual);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: ColoredBox(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: widget.immersives.length,
                    itemBuilder: (_, index) => TimelineItemContent(
                      widget.immersives.elementAt(index),
                    ),
                    onPageChanged: (index) => setState(
                      () => _actual = index,
                    ),
                  ),
                ),
                TimelineDateNavigation(
                  dates: widget.immersives.map((e) => e.date).toSet(),
                  onPressed: (index) => setState(() {
                    _actual = index;
                    _controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }),
                  current: _actual,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
