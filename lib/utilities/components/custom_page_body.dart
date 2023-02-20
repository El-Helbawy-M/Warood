import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/blocs/user_bloc.dart';
import 'package:flutter_project_base/utilities/theme/media.dart';
import '../../config/app_states.dart';

class CustomPageBody extends StatelessWidget {
  const CustomPageBody({super.key, required this.body, this.drawer, this.appBar, this.backgroundColor});
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? drawer;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppStates>(
      builder: (context, state) {
        bool isDone = state is Done;
        return Scaffold(
          drawer: drawer,
          backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
          appBar: appBar,
          body: SizedBox(
            width: MediaHelper.width(context),
            height: MediaHelper.height(context),
            child: isDone ? body : const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
