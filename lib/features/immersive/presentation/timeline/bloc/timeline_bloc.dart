import 'package:flutter_bloc/flutter_bloc.dart';

class TimelineBloc extends Bloc {
  TimelineBloc(super.initialState);

  int page = 0;

  DateTime get initialDate => DateTime.now()
    ..subtract(
      Duration(days: (page + 1) * 5),
    );
  DateTime get endDate => DateTime.now()
    ..subtract(
      Duration(days: page * 5),
    );
}
