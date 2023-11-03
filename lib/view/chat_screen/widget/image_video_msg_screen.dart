import 'dart:io';
import 'dart:ui';

import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:flutter/material.dart';

class ImageVideoMsgScreen extends StatefulWidget {
  final String? image;
  final Function({String? text}) onIVSubmitClick;

  const ImageVideoMsgScreen(
      {Key? key, this.image, required this.onIVSubmitClick})
      : super(key: key);

  @override
  State<ImageVideoMsgScreen> createState() => _ImageVideoMsgScreenState();
}

class _ImageVideoMsgScreenState extends State<ImageVideoMsgScreen> {
  TextEditingController textController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
        decoration: BoxDecoration(
          color: colorPrimaryDark,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: InkWell(
          onTap: () {
            textFocusNode.unfocus();
            setState(() {});
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 12, right: 10, bottom: 3),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    Center(
                      child: Text(
                        S.of(context).sendMedia,
                        style:
                            TextStyle(fontFamily: fNSfUiMedium, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: colorTextLight,
              ),
              Text(
                S.of(context).writeMessage,
                style: TextStyle(
                    fontFamily: fNSfUiRegular,
                    fontSize: 15,
                    color: colorTextLight),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 2.7,
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: colorPink,
                          blurRadius: 8,
                          offset: Offset(1, 1),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: widget.image == null || widget.image!.isEmpty
                          ? Image.asset(
                              icUserPlaceHolder,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(widget.image ?? ''),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      margin: EdgeInsets.only(right: 7, left: 9),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: textController,
                        focusNode: textFocusNode,
                        expands: false,
                        maxLines: 10,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: fNSfUiRegular,
                          fontSize: 13,
                          letterSpacing: 0.7,
                          height: 1.3,
                        ),
                        cursorHeight: 15,
                        cursorColor: Colors.white,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onIVSubmitClick(text: textController.text);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(colorPrimary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  child: Text(
                    S.of(context).submit.toUpperCase(),
                    style: TextStyle(
                      fontFamily: fNSfUiSemiBold,
                      letterSpacing: 1,
                      color: colorIcon,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
