import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/generated/assets.gen.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({required this.totalStores, super.key});
  final int totalStores;

  static const TimeOfDay _morningStart = TimeOfDay(hour: 6, minute: 0);
  static const TimeOfDay _afternoonStart = TimeOfDay(hour: 12, minute: 0);
  static const TimeOfDay _eveningStart = TimeOfDay(hour: 18, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _InfoSection(totalStores: totalStores)),
        const Spacer(),
        SizedBox(
          width: 48,
          height: 48,
          child: TextButton(
            onPressed: () {},
            child: Assets.icon.search.svg(),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 48,
          height: 48,
          child: TextButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(CustomColors.of(context).background)),
            onPressed: () {},
            child: Icon(Icons.add, color: CustomColors.of(context).primary),
          ),
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.totalStores});
  final int totalStores;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Assets.icon.sun.svg(),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(text: welcomeSign.tr(), style: CustomTextStyles.of(context).medium12),
            ],
          ),
        ),
        Text(
          LocaleKeys.home_numOfStores,
          style: CustomTextStyles.of(context).medium24,
        ).tr(
          namedArgs: {'storesAmount': totalStores.toString()},
        ),
      ],
    );
  }

  String get welcomeSign {
    final currentTime = TimeOfDay.now();
    if (currentTime.isBefore(HomeAppBar._afternoonStart) && currentTime.isAfter(HomeAppBar._morningStart)) {
      return LocaleKeys.home_goodMorning;
    }

    if (currentTime.isBefore(HomeAppBar._eveningStart) && currentTime.isAfter(HomeAppBar._afternoonStart)) {
      return LocaleKeys.home_goodAfternoon;
    }

    return LocaleKeys.home_goodEvening;
  }
}
