import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/domain/exceptions/exceptions.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_state.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_carousel.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_error.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_header.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_loading.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_logo.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_page_navigation.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key, required this.bloc});

  final TimelineBloc bloc;

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  int _page = 0;
  bool _isBusy = false;

  @override
  void initState() {
    widget.bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const TimelineHeader(),
            BlocConsumer<TimelineBloc, TimelineState>(
              bloc: widget.bloc,
              listener: _blocListener,
              builder: _blocBuilder,
            ),
            TimelinePageNavigation(
              prev: _isBusy
                  ? null
                  : () {
                      setState(() {
                        _page++;
                      });
                      widget.bloc.prev();
                    },
              next: _isBusy || _page == 0
                  ? null
                  : () {
                      setState(() {
                        _page--;
                      });
                      widget.bloc.next();
                    },
            ),
          ],
        ),
      ),
    );
  }

  Widget _blocBuilder(BuildContext context, TimelineState state) {
    return Expanded(
      child: Center(
        child: switch (state) {
          TimelineInitialState() => const TimelineLogo(),
          TimelineInProgressState() => const TimelineLoading(),
          TimelineSuccessState() => TimelineCarousel(state.immersives),
          TimelineErrorState() => TimelineError(widget.bloc.refresh)
        },
      ),
    );
  }

  void _blocListener(BuildContext context, TimelineState state) {
    if (state is TimelineInProgressState) {
      setState(() {
        _isBusy = true;
      });
    } else {
      setState(() {
        _isBusy = false;
      });
    }
    if (state is TimelineErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            switch (state.error) {
              ServerException() => 'Error getting the data from the server',
              LocalStorageReadException() =>
                'Error reading the data from your storage',
              LocalStorageWriteException() =>
                'Error writing the data to your storage',
              NoRemoteDataException() => 'No data was found on the server',
              NoLocalDataException() =>
                'No cached data was found, connect to the internet and retry',
              ImageDownloadException() =>
                'One or more images could not be downloaded',
            },
          ),
        ),
      );
    }
  }
}
