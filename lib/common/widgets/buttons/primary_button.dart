import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../styles/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.text,
    this.bgColor,
    this.textStyle,
    this.onPressed,
    this.textColor,
    this.height = 40,
    this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 21),
    this.shape,
    this.icon,
    this.iconColor,
    this.isEnabled = true,
  });

  final String? text;
  final Color? textColor;
  final Color? bgColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final OutlinedBorder? shape;
  final String? icon;
  final Color? iconColor;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          disabledBackgroundColor: context.color.inactive,
          backgroundColor: bgColor ?? context.color.primary,
          elevation: 0,
          side: BorderSide.none,
          padding: padding,
          foregroundColor: textColor ?? context.color.onPrimary,
          shape:
              shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.double16),
              ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (text != null)
              Flexible(
                child: Text(
                  text!,
                  style: (textStyle ?? context.text.medium16).copyWith(
                    color: textColor ?? context.color.onPrimary,
                  ),
                ),
              ),
            if (icon != null)
              SvgPicture.asset(
                icon!,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  iconColor ?? context.color.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
