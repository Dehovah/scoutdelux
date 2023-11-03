import 'package:bubbly/utils/colors.dart';
import 'package:flutter/material.dart';

class LoaderDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: colorPrimaryDark,
        child: Center(
          child: CircularProgressIndicator(
            color: colorTheme,
          ),
        ),
      ),
    );
  }
}
