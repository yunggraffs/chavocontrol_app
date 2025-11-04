import 'package:chavocontrol_app/config/app_colors.dart';
import 'package:chavocontrol_app/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Container(
        color: AppColors.primary,
        child: Center(
          child: Text("Bienvenido a ChavoControl"),
        ),
      )
    );
  }
}