import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/config/app_states.dart';

class DigitalCounterCubit extends Cubit<AppStates> {
  DigitalCounterCubit() : super(Done());
}
