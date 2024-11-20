import 'package:flutter/material.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';
import 'package:tomnam/utils/constants/sizes.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static final lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle()
        .copyWith(fontSize: TSizes.fontSm, color: AppColors.blackColor),
    hintStyle: const TextStyle()
        .copyWith(fontSize: TSizes.fontSm, color: AppColors.blackColor),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: AppColors.blackColor.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.grayColor),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.fontSm),
      borderSide: const BorderSide(width: 1, color: AppColors.grayColor),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.fontSm),
      borderSide: const BorderSide(width: 1, color: AppColors.blackColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.fontSm),
      borderSide:
          const BorderSide(width: 1, color: AppColors.accentRedOrangeColor),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.fontSm),
      borderSide:
          const BorderSide(width: 2, color: AppColors.accentOrangeColor),
    ),
  );

  static final darklightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle()
        .copyWith(fontSize: TSizes.fontSm, color: AppColors.blackColor),
    hintStyle: const TextStyle()
        .copyWith(fontSize: TSizes.fontSm, color: AppColors.blackColor),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: AppColors.blackColor.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.grayColor),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.grayColor),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: AppColors.whiteColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide:
          const BorderSide(width: 1, color: AppColors.accentRedOrangeColor),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide:
          const BorderSide(width: 2, color: AppColors.accentOrangeColor),
    ),
  );
}
