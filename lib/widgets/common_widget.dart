import 'package:flutter/material.dart';
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
