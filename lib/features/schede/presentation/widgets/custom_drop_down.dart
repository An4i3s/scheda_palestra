import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';

class CustomDropDown extends StatefulWidget{
  const CustomDropDown({super.key, required this.onChanged, required this.label});
  final Function(int rest) onChanged;
  final String label;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  int? _value = 60;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        Container(
          
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(16)
          ),
          child: DropdownButton(
            value: _value,
            isExpanded: true,
            underline: SizedBox(),
            dropdownColor: AppColors.backgroundColor,
            items: [
            DropdownMenuItem(value: 30,child: Text("30s"),),
            DropdownMenuItem(value: 60,child: Text("60s",),),
            DropdownMenuItem(value: 90,child: Text("90s"),),
            DropdownMenuItem(value: 180,child: Text("2m"),),
          ], 
          onChanged: (v){
            setState(() {
              _value = v;
            });
            
            widget.onChanged(v??60);
          }),
        ),
      ],
    );
  }
}