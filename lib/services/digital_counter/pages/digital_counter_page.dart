import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_project_base/services/digital_counter/controllers/digital_counter_controller.dart';
import 'package:flutter_project_base/utilities/components/custom_btn.dart';
import 'package:flutter_project_base/utilities/theme/media.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class DigitalCounterPage extends StatefulWidget {
  const DigitalCounterPage({super.key});

  @override
  State<DigitalCounterPage> createState() => _DigitalCounterPageState();
}

class _DigitalCounterPageState extends State<DigitalCounterPage> {
  DigitalCounterController controller = DigitalCounterController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مسبحة الكترونية"),
        elevation: 0,
      ),
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: Column(
          children: [
            const SizedBox(height: 24),
            DigitalValueCard(title: "الدورة", value: controller.turn),
            const SizedBox(height: 16),
            DigitalValueCard(title: "العد الكلي", value: controller.totalCounter),
            const SizedBox(height: 24),
            InkWell(
              onTap: () => setState(() => controller.increment()),
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(125),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    controller.counter.toString(),
                    style: AppTextStyles.w600.copyWith(fontSize: 36, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomBtn(
                text: "إعادة العد",
                onTap: () => setState(() => controller.reset()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DigitalValueCard extends StatelessWidget {
  const DigitalValueCard({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaHelper.width,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.w500.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            value.toString(),
            style: AppTextStyles.w400.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
