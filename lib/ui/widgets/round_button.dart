import 'package:flutter/material.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';


class RoundButton extends SizedBox {
  RoundButton({
    bool filled = true,
    double height = 46.0,
    double width=240.0,
    Color color1 = StyledColors.primaryColor,
    Color color2 = Colors.white,
    Color? borderColor,
    required VoidCallback onClicked,
    required String text,
  }) : super(
          height: height,
          child: MaterialButton(
            color: filled ? color1 : color2,
            elevation: 0,
            onPressed: onClicked,
            minWidth: width,
            shape: onClicked == null ? null : RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? (filled ? color1 : color2),
              ),
              borderRadius: BorderRadius.circular(height / 4),
            ),
            disabledColor: StyledColors.primaryColor,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1.25,
                color: filled ? color2 : color1,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
}
