import 'package:flutter/material.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/utilities/extensions/list_extensions.dart';
import 'package:flutter_project_base/utilities/theme/media.dart';
import 'package:lottie/lottie.dart';
import '../../routers/navigator.dart';
import '../../utilities/components/custom_btn.dart';
import '../../utilities/theme/text_styles.dart';

class RewardBottomSheet extends StatelessWidget {
  const RewardBottomSheet({Key? key, required this.imageName, required this.mainText, required this.subText, this.actionBtnName, this.okBtnName, this.onActionClick, this.onOkClick}) : super(key: key);
  final String imageName;
  final String mainText, subText;
  final String? actionBtnName, okBtnName;
  final Function()? onActionClick, onOkClick;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => CustomNavigator.pop(),
                  child: Container(
                    width: 37,
                    height: 37,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(width: .5)),
                    child: drawSvgIcon("close_square", iconColor: Theme.of(context).iconTheme.color),
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Container(
                  //   width: MediaHelper.width(context),
                  //   height: 224,
                  //   padding: EdgeInsets.all(24),
                  //   decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/reward_bg.jpg"), fit: BoxFit.cover)),
                  // ),
                  LottieBuilder.asset(
                    "assets/lottie/celebrate.json",
                    height: 224,
                    width: MediaHelper.width,
                    fit: BoxFit.cover,
                  ),
                  drawSvgIcon("rewards/$imageName", width: 200, height: 200),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                mainText,
                style: AppTextStyles.w600.copyWith(fontSize: 34, color: Theme.of(context).textTheme.titleSmall!.color),
              ),
              const SizedBox(height: 8),
              Text(
                subText,
                style: AppTextStyles.w500.copyWith(fontSize: 14, color: Theme.of(context).textTheme.titleLarge!.color),
              ),
              const SizedBox(height: 8),
              Text(
                words.getRandomValue,
                style: AppTextStyles.w400.copyWith(fontSize: 14, color: Theme.of(context).hintColor),
              ),
              const SizedBox(height: 32),
              CustomBtn(
                height: 56,
                text: getLang("thank_god"),
                radius: 10,
                onTap: () => CustomNavigator.pop(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }
}

List<String> words = [
  "إن كنتُم تحبُّونَ حِلْيَةَ الجنَّةِ و حريرَها فلا تلبَسوها في الدُّنيا",
  "لو كانتِ الدُّنيا تعدلُ عندَ اللهِ جناحَ بعوضةٍ ما سقى كافرًا منها شربةَ ماءٍ",
  "لَا يُؤْمِنُ أحَدُكُمْ، حتَّى يُحِبَّ لأخِيهِ ما يُحِبُّ لِنَفْسِهِ",
  "مَنْ أحبَّ اللهَ وَرسولَهُ فَقدْ أحبَّ النَّاسَ جميعًا",
  "إذا أحبَّ الرجلُ أخاه فلْيخبره أنّه يحبُّه",
  "لا يُؤْمِنُ أحدُكم حتى أكونَ أحبَّ إليه من ولدِهِ، ووالدِهِ، والناسِ أجمعينَ",
  "من أحبَّ الناسَ فليُقربَهم للهِ",
  "إنَّ صاحبَ حُسنِ الخلقِ ليبلُغُ بِهِ درجةَ صاحبِ الصَّومِ والصَّلاةِ",
  "ما شيءٌ أثقلُ في ميزانِ المؤمِنِ يومَ القيامةِ مِن خُلُقٍ حسَنٍ، فإنَّ اللَّهَ تعالى ليُبغِضُ الفاحشَ البَذيءَ",
  "ما يُصِيبُ المُؤْمِنَ مِن وصَبٍ، ولا نَصَبٍ، ولا سَقَمٍ، ولا حَزَنٍ حتَّى الهَمِّ يُهَمُّهُ، إلَّا كُفِّرَ به مِن سَيِّئاتِهِ",
  "مَن يَدْخُلُ الجَنَّةَ يَنْعَمُ لا يَبْأَسُ، لا تَبْلَى ثِيابُهُ ولا يَفْنَى شَبابُهُ",
];
