import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/rounded_button.dart';
import 'package:shopengo/generated/assets.gen.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    required this.totalStores,
    required this.isCreating,
    required this.isSearching,
    required this.onAddPressed,
    required this.onSearchPressed,
    required this.onCancel,
    required this.onCreateStore,
    super.key,
  });

  final int totalStores;
  final bool isCreating;
  final bool isSearching;
  final VoidCallback onAddPressed;
  final VoidCallback onSearchPressed;
  final VoidCallback onCancel;
  final VoidCallback onCreateStore;

  static const TimeOfDay _morningStart = TimeOfDay(hour: 6, minute: 0);
  static const TimeOfDay _afternoonStart = TimeOfDay(hour: 12, minute: 0);
  static const TimeOfDay _eveningStart = TimeOfDay(hour: 18, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _InfoSection(totalStores: totalStores)),
        const Spacer(),
        if (isCreating) ...[
          RoundedButton(
            icon: Icons.close,
            backgroundColor: CustomColors.of(context).cancel,
            iconColor: CustomColors.of(context).background,
            onPressed: onCancel,
          ),
          const SizedBox(width: 8),
          RoundedButton(
            icon: Icons.check,
            backgroundColor: CustomColors.of(context).confirm,
            iconColor: CustomColors.of(context).background,
            onPressed: onCreateStore,
          ),
        ],
        if (isSearching) ...[],
        if (!isCreating && !isSearching) ...[
          SizedBox(
            width: 48,
            height: 48,
            child: TextButton(
              onPressed: onSearchPressed,
              child: Assets.icon.search.svg(),
            ),
          ),
          const SizedBox(width: 8),
          RoundedButton(
            icon: Icons.add,
            backgroundColor: CustomColors.of(context).background,
            iconColor: CustomColors.of(context).primary,
            onPressed: onAddPressed,
          ),
        ],
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
              TextSpan(text: welcomeSign.tr().toUpperCase(), style: CustomTextStyles.of(context).medium12),
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
