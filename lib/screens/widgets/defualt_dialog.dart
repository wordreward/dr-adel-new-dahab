
import 'dart:ui';

import 'package:adelnewversion/core/theme/colors.dart';
import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  const DefaultDialog({Key? key, required this.onPressed, required this.title, required this.body, required this.cancel, required this.accept, required this.onPressedCancel, this.content, this.size}) : super(key: key);

  final void Function() onPressed;
  final void Function() onPressedCancel;
  final String title;
  final Widget? content;
  final String body;
  final String cancel;
  final String accept;
  final double? size;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape
                .rectangle,
            borderRadius:
            BorderRadius
                .circular(
                25)),
        child: AlertDialog(
          backgroundColor:
          Colors.white.withOpacity(0.25),
          elevation: 2,
          clipBehavior: Clip
              .antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(
                      20.0))),
          title: Text(
              title,
              style: const TextStyle(
                  color: Colors
                      .white,
                  fontSize:
                  18,
                  fontWeight:
                  FontWeight
                      .bold)),
          content: content ?? Text(
              body,
              style: const TextStyle(
                  color: Colors
                      .white,
                  fontSize:
                  16)),
          actions: <Widget>[
            Padding(
              padding:
              const EdgeInsets
                  .all(
                  8.0),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment
                    .center,
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceAround,
                children: [
                  Container(
                    width: w*0.3,
                    height: h*0.06,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10),
                        border: Border.all(color: Colors.white)),
                    child:
                    TextButton(
                        onPressed: onPressedCancel,
                        child: Text(
                            cancel,
                            style: TextStyle(color: Colors.white, fontSize: size ?? 16))
                    ),
                  ),
                  Container(
                    width: w*0.3,
                    height: h*0.06,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.white)),
                    child:
                    TextButton(
                      onPressed: onPressed,
                      child: Text(
                          accept,
                          style: const TextStyle(color: primaryComponentColor, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
