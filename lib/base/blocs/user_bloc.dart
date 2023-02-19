import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/models/user_model.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/handlers/shared_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';

class UserBloc extends Bloc<AppEvents, AppStates> {
  UserBloc() : super(Loading()) {
    on<Get>(_getUser);
    on<Update>(_updateUser);
    on<SetState>(_setState);
    add(Get());
  }
  static UserBloc get bloc => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  late UserModel model;

  // functions
  _getUser(AppEvents event, Emitter emit) async {
    var data = await SharedHandler.instance!.getData(key: SharedKeys().user, valueType: ValueType.map);
    model = UserModel.formJson(data);
    emit(Done());
  }

  _updateUser(AppEvents event, Emitter emit) async {
    model = event.arguments;
    emit(Done());
    SharedHandler.instance!.setData(SharedKeys().user, value: model.toMap());
  }

  _setState(AppEvents event, Emitter emit) {
    emit(Done());
  }
}
