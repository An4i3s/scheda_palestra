
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/core/widgets/custom_keyboard_controller.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required TextEditingController nomeController, this.hintText, required this.label, this.isNum, this.hasValidations, required this.isReadOnly, 
    this.keyboardMode = CustomKeyboardMode.numeric,
  }) : _controller = nomeController;

  final TextEditingController _controller;
  final String? hintText;
  final String label;
  final bool? isNum;
  final bool? hasValidations;
  final bool isReadOnly;
  final CustomKeyboardMode keyboardMode;
  
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        SizedBox(height: 4,),
        TextFormField(
          controller: _controller,
          readOnly: isReadOnly,
          onTap: isReadOnly ? () {
            CustomKeyboardController.instance.open(_controller,  mode: keyboardMode,);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Scrollable.ensureVisible(
                context,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                alignment: 0.5, // centra il campo nello spazio visibile
              );
            });
          } :null,
          keyboardType: (isNum??false) ? TextInputType.number : null,
          decoration:  InputDecoration(
            suffixIcon: IconButton(icon: Icon(Icons.cancel,color: AppColors.restDayColor), onPressed: _controller.clear,),
            filled: true,
            fillColor: AppColors.containerColor.withAlpha(175),
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColors.secondaryBorderContainerColor)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryBorderContainerColor), borderRadius: BorderRadius.circular(16),),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(16),),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(16),),
            errorStyle: TextStyle(fontSize: 0)
          ),
          validator:
           (v) =>
              (v == null || v.trim().isEmpty) && (hasValidations??true) ?  '' : null,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }
}