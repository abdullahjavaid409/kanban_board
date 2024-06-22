import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      decoration: InputDecoration(
        prefixIcon: prefix,
        labelText: labelText,
        contentPadding: const EdgeInsets.all(16).r,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ??
            Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
        filled: true,
        fillColor: Colors.white,
        border: border ??
            OutlineInputBorder(
              borderSide: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
      ),
      validator: validator,
    );
  }
}
