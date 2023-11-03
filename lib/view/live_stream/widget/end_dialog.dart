import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:flutter/material.dart';

class EndDialog extends StatelessWidget {
  final VoidCallback onYesBtnClick;

  const EndDialog({Key? key, required this.onYesBtnClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 70),
      backgroundColor: colorPrimaryDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AspectRatio(
        aspectRatio: 1 / 0.6,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Are you Sure',
                style: TextStyle(fontFamily: fNSfUiBold, fontSize: 16),
              ),
              Spacer(),
              Text(
                'Are you sure you want to end your live video?',
                style: TextStyle(fontFamily: fNSfUiLight),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(child: Text('Cancel')))),
                  Expanded(
                    child: InkWell(
                      onTap: onYesBtnClick,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft,
                            colors: [
                              colorPink,
                              colorTheme,
                            ],
                          ),
                        ),
                        child: Text('Yes'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
