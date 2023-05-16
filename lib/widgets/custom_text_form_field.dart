import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  const CustomTextFormField({
    Key? key,
    required this.label,
    this.hintText,
    this.textInputAction, 
    this.focusNode, 
    this.onFieldSubmitted,
    this.validator,
    this.onSaved, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            onSaved: onSaved,
            validator: validator,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.black45,
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignCenter
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.amberAccent,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignCenter
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
            ),
            textInputAction: textInputAction,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
          )
        ],
      ),
    );
  }
}
