
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required TextEditingController nomeController, this.hintText, required this.label, this.isNum,
  }) : _controller = nomeController;

  final TextEditingController _controller;
  final String? hintText;
  final String label;
  final bool? isNum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        SizedBox(height: 4,),
        TextFormField(
          controller: _controller,
          keyboardType: (isNum??false) ? TextInputType.number : null,
          decoration:  InputDecoration(
            filled: true,
            fillColor: AppColors.containerColor.withAlpha(175),
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColors.borderContainerColor)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.borderContainerColor), borderRadius: BorderRadius.circular(16),),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryBtnColor), borderRadius: BorderRadius.circular(16),)
          ),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Campo obbligatorio' : null,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }
}