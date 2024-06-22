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

    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );
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
      colorScheme: const ColorScheme.light().copyWith(
        onError: const Color(0xffFE0000),
        onTertiary: const Color(0xff7CFF01),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      iconTheme: IconThemeData(size: 20.h),
      listTileTheme: ListTileThemeData(
        iconColor: primaryColor,
        textColor: AppColors.textColor,
        titleTextStyle: textTheme.bodyLarge,
        subtitleTextStyle: textTheme.bodyMedium,
        contentPadding: EdgeInsets.zero,
      ),
      switchTheme: const SwitchThemeData(
        trackColor: WidgetStatePropertyAll(primaryColor),
        thumbColor: WidgetStatePropertyAll(AppColors.textColor),
      ),
      tabBarTheme: TabBarTheme(
        dividerColor: Colors.transparent,
        unselectedLabelColor: AppColors.textColor,
        labelColor: AppColors.textColor,
        labelStyle: textTheme.bodyLarge,
        unselectedLabelStyle: textTheme.bodyLarge,
        indicatorColor: Colors.transparent,
        labelPadding: EdgeInsets.zero,
        indicatorSize: TabBarIndicatorSize.label,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 1222,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(18, 18, 18, 0.70),
        selectedItemColor: primaryColor,
        unselectedItemColor: AppColors.textColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
