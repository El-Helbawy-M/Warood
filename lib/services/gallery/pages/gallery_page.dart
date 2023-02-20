import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/base/blocs/user_bloc.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/utilities/components/custom_page_body.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    log(UserBloc.bloc.model.indexOfNextRewardToUnlock.toString());
    return CustomPageBody(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Gallery"),
        elevation: 0,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        physics: const BouncingScrollPhysics(),
        itemCount: 25,
        itemBuilder: (context, index) {
          List<int> values = UserBloc.bloc.model.rewards!.values.toList();
          return GalleryItem(
            image: (index + 1).toString(),
            progress: (UserBloc.bloc.model.indexOfNextRewardToUnlock == index) ? values[index - 1] : (values.length - 1 >= index ? values[index] : 0),
            isNextReward: UserBloc.bloc.model.indexOfNextRewardToUnlock == index,
            isLocked: UserBloc.bloc.model.indexOfNextRewardToUnlock < index,
          );
        },
      ),
    );
  }
}

class GalleryItem extends StatelessWidget {
  const GalleryItem({
    Key? key,
    required this.image,
    required this.progress,
    required this.isNextReward,
    required this.isLocked,
  }) : super(key: key);

  final String image;
  final int progress;
  final bool isNextReward;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    log(progress.toString());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isLocked || isNextReward ? Theme.of(context).primaryColor : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!(isLocked || isNextReward)) Expanded(child: drawSvgIcon("rewards/$image", width: 64, height: 64)),
          if (!(isLocked || isNextReward)) const SizedBox(height: 8),
          if (!(isLocked || isNextReward))
            Text(
              progress.toString(),
              style: AppTextStyles.w500.copyWith(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          if (isLocked || isNextReward) drawSvgIcon("lock", iconColor: Colors.white),
          if (isLocked || isNextReward) const SizedBox(height: 8),
          if (isNextReward)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: LinearProgressIndicator(
                value: (progress / 30),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          if (isNextReward)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  drawSvgIcon("rewards/${int.parse(image) - 1}", width: 16, height: 16),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${30 - progress} to Unlock",
                      style: AppTextStyles.w500.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
