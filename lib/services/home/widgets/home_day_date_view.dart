import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import '../../../base/blocs/settings_bloc.dart';
import '../../../config/app_events.dart';
import '../../../config/app_states.dart';
import '../../../handlers/permission_handler.dart';
import '../../../utilities/components/custom_btn.dart';
import '../../../utilities/components/custom_shimmer_view.dart';
import '../../../utilities/theme/text_styles.dart';
import '../Blocs/pray_time_bloc.dart';
import '../models/network_models/prayer_time_model.dart';

class HomeDayDate extends StatelessWidget {
  const HomeDayDate({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayTimeBloc, AppStates>(
      builder: (context, state) {
        if (state is Done) {
          PrayerTimeModel model = state.model as PrayerTimeModel;
          return Text("${model.date!.readable ?? ""} / ${model.date!.hijri!.date ?? ""}", style: AppTextStyles.w500.copyWith(fontSize: 18, color: Colors.white));
        } else if (state is Loading) {
          return CustomShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [CustomShimmerText(width: 160), SizedBox(height: 8), CustomShimmerText(width: 180)],
            ),
          );
        } else if (state is Empty || state is Error) {
          return CustomBtn(
            radius: 8,
            text: getLang("try_again"),
            height: 36,
            width: 160,
            buttonColor: settings.settingsModel.valueOrNull!.theme.pendingColor,
            onTap: () async {
              PrayTimeBloc.instance.add(Get());
            },
          );
        } else {
          return CustomBtn(
            radius: 8,
            text: getLang("allow_your_location"),
            height: 36,
            width: 160,
            // textColor: Colors.black,
            buttonColor: settings.settingsModel.valueOrNull!.theme.pendingColor,
            onTap: () async {
              if (await PermissionHandler().checkLocationPermission()) {
                PrayTimeBloc.instance.add(Get());
              }
            },
          );
        }
      },
    );
  }
}
