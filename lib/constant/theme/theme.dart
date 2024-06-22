import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/constant/app_color/app_colors.dart';
import 'package:kanban_board/constant/theme/text_theme.dart';

class AppTheme {
  static lightTheme(BuildContext context) {
    const primaryColor = AppColors.primaryColor;

    final textTheme = AppTextTheme.lightTheme(context);

    final buttonTextStyle = WidgetStatePropertyAll(
      textTheme.bodyMedium?.copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w500,
      ),
    );

    final borderRadius = BorderRadius.circular(14);

    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      fixedSize: Size(1.sw, 51.h),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
    return ThemeData(
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          textStyle: buttonTextStyle,
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          foregroundColor: const WidgetStatePropertyAll(primaryColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      iconTheme: IconThemeData(size: 15.h),
      listTileTheme: ListTileThemeData(
        iconColor: primaryColor,
        textColor: AppColors.textColor,
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodyMedium,
        contentPadding: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        thickness: 0.2,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          side: const BorderSide(color: AppColors.textColor),
        ),
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: textTheme.titleSmall,
        iconColor: AppColors.textColor,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.backgroundColor,
        textStyle: textTheme.bodyMedium,
        iconColor: AppColors.textColor,
        position: PopupMenuPosition.under,
        labelTextStyle: WidgetStatePropertyAll(
            textTheme.bodyMedium?.copyWith(color: AppColors.textColor)),
      ),
    );
  }
}
