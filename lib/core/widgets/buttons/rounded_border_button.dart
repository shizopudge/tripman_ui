import 'package:flutter/material.dart';
import 'package:tripman/core/constants/styles/styles.dart';

class RoundedBorderButton extends StatelessWidget {
  final VoidCallback? onTap;
  final List<Widget> children;
  final Color backgroundColor;
  final Color borderColor;
  final double bordeRadius;
  final EdgeInsets margin;
  final double verticalPadding;
  final double horizontalPadding;
  final MainAxisSize mainAxisSize;
  const RoundedBorderButton({
    super.key,
    required this.onTap,
    required this.children,
    this.backgroundColor = kWhite,
    required this.borderColor,
    this.bordeRadius = 100.0,
    this.margin = EdgeInsets.zero,
    this.verticalPadding = 15,
    this.horizontalPadding = 0,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        100,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: verticalPadding,
        ),
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(
            bordeRadius,
          ),
        ),
        child: children.length > 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: mainAxisSize,
                children: children,
              )
            : Center(
                child: children.first,
              ),
      ),
    );
  }
}
