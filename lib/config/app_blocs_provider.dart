import 'package:flutter_bloc/src/bloc_provider.dart' show BlocProvider, BlocProviderSingleChildWidget;
import 'package:flutter_project_base/base/blocs/lang_bloc.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    // BlocProvider<LangBloc>(create: (_) => LangBloc()),
  ];
}
