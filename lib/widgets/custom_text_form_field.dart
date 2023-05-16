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
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical(y: 0.8),
              onSaved: onSaved,
              validator: validator,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: Colors.black45,
                    width: 1.5,
                    strokeAlign: BorderSide.strokeAlignCenter
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
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
            ),
          )
        ],
      ),
    );
  }
}
