import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/constant/app_color/app_colors.dart';
import 'package:kanban_board/constant/constants.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({super.key, this.of = 20});

  final double of;

  @override
  Widget build(BuildContext context) => SizedBox(height: of.h);
}

class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing({super.key, this.of = 20});

  final double of;

  @override
  Widget build(BuildContext context) => SizedBox(width: of.w);
}

class KanBoardContainer extends StatelessWidget {
  final Widget? child;
  final BuildContextCallback? onPressed;
  final double? width;
  final EdgeInsets? margin;
  final DecorationImage? image;
  final BoxBorder? border;
  final BoxShape shape;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final EdgeInsets? padding;
  final double? height;
  final Alignment? alignment;

  const KanBoardContainer(
      {super.key,
      this.child,
      this.width,
      this.height,
      this.alignment,
      this.color,
      this.padding,
      this.image,
      this.border,
      this.borderRadius,
      this.shape = BoxShape.rectangle,
      this.onPressed,
      this.margin,
      this.gradient,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed == null ? null : () => onPressed!(context),
      child: Container(
        margin: margin,
        alignment: alignment,
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            boxShadow: boxShadow,
            color: gradient == null ? color : null,
            border: border,
            gradient: color == null ? gradient : null,
            image: image,
            borderRadius: borderRadius,
            shape: shape),
        child: child,
      ),
    );
  }
}

class KanBoardTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefix;
  final bool isReadOnly;
  final AutovalidateMode? autoValidateMode;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;

  const KanBoardTextField({
    super.key,
    this.hintText,
    this.prefix,
    this.suffixIcon,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.validator,
    this.hintStyle,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines,
    this.inputFormatters,
    this.textInputAction,
    this.autoValidateMode,
    this.labelText,
    this.isReadOnly = false,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      readOnly: isReadOnly,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.bodySmall,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        prefixIcon: prefix,
        labelText: labelText,
        contentPadding: const EdgeInsets.all(16).r,
        suffixIcon: suffixIcon,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: border ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: AppColors.lightBlack.withOpacity(0.1))),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: AppColors.lightBlack.withOpacity(0.1))),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: AppColors.lightBlack.withOpacity(0.1))),
      ),
      validator: validator,
    );
  }
}

class KanBoardElevatedButton extends StatelessWidget {
  final BuildContextCallback? onTap;
  final String title;
  final Color? color;
  final Size? size;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final double borderRadius;
  final VisualDensity? visualDensity;
  final Widget? child;
  final OutlinedBorder? shape;

  const KanBoardElevatedButton({
    required this.title,
    super.key,
    this.borderRadius = 13,
    this.size,
    this.padding,
    required this.onTap,
    this.child,
    this.color = AppColors.backgroundColor,
    this.textStyle,
    this.shape,
    this.visualDensity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: size,
          padding: padding,
          visualDensity: visualDensity,
          shape: shape,
        ),
        child: child ??
            Text(
              title,
              maxLines: 1,
              style: textStyle ?? Theme.of(context).textTheme.bodyLarge,
            ),
        onPressed: () => onTap == null ? null : onTap!(context),
      ),
    );
  }
}
