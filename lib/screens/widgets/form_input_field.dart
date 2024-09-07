import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:flutter/material.dart';
import '../../../core/core.dart';


class FormInputField extends StatelessWidget {
  const FormInputField({
    Key? key,
    required this.controller,
    required this.prefixText,
    required this.validator,
    this.hintText = '',
    this.maxLines = 1,
    this.scure,
    this.color,
    this.autoFillHints,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final TextEditingController controller;
  final String prefixText;
  final String hintText;
  final int maxLines;
  final bool? scure;
  final Color? color;
  final String? Function(String?)? validator;
  final Iterable<String>? autoFillHints;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10,height: 25,),
            Text(
              prefixText,
              style: Fonts().primaryFont(15, FontWeight.normal)
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: color ?? secondComponentColor,
            maxLines: maxLines,
            keyboardType: keyboardType,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            obscureText: scure ?? false,
            autofillHints: autoFillHints ?? <String>[],
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff77787D),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff77787D),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff77787D),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              contentPadding: EdgeInsets.all(15),
            ),
            //textDirection: appLanguage.isEn ? TextDirection.ltr : TextDirection.rtl,
            style: Fonts().primaryFont(16, FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
