import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/back_up_widget.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/language_section.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: Container(
        color: AppColors.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.settings, color: AppColors.primaryColor),
                      Text(
                        context.i18n.settings,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(color: AppColors.borderContainerColor, thickness: 2),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LanguageWidget(),
                ),
                Padding(padding: const EdgeInsets.all(16.0), child: BackupWidget()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("${_packageInfo.version}+${_packageInfo.buildNumber}"),
            )
          ],
        ),
      ),
    );
  }
}
