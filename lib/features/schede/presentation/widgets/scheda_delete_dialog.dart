
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class SchedaDeleteDialog extends StatelessWidget {
  const SchedaDeleteDialog({
    super.key,
    required this.schedaModel, required this.onDelete,
  });

  final SchedaModel schedaModel;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 24,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 16,
              children: [
                Container(
                  decoration: BoxDecoration(
                     color: Colors.red[50],
                     borderRadius: BorderRadius.circular(16)
                  ),
                 
                  child: SvgPicture.asset("assets/icons/trash.svg", width: 64, height: 64, colorFilter: ColorFilter.mode(AppColors.primaryBtnColor, BlendMode.srcIn),
                ),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.i18n.deleteGymSheet, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Text(context.i18n.deleteConfirmMessage(schedaModel.nome), style: TextStyle(fontSize: 16,),),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(child: OutlinedButton(
                  onPressed: ()=> Navigator.pop(context),
                 style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.containerColor), side: WidgetStatePropertyAll(BorderSide.none), padding: WidgetStatePropertyAll(EdgeInsets.all(8)) ),
                 child: Text(context.i18n.cancel, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),)),
                Expanded(child: OutlinedButton(onPressed: (){
                  onDelete();
                  Navigator.pop(context);
                } , 
                 style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primaryBtnColor), side: WidgetStatePropertyAll(BorderSide.none), padding: WidgetStatePropertyAll(EdgeInsets.all(8))),
                child: Text(context.i18n.delete, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
