import 'package:flutter/material.dart';
import 'package:sankore_app/utils/colors.dart';
import 'package:sankore_app/widgets/small_text.dart';

class AppButton extends StatelessWidget {
  final Function()? onPress;
  final String buttonText;
  final Color buttonColor;

  AppButton(
      {required this.buttonText,
      required this.buttonColor,
      @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: SmallText(
            size: 16,
            text: buttonText,
            color: AppColors.mainBlackColor,
          ),
        ),
      ),
    );
  }
}
