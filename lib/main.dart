import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(BreakingBadApp());
}

class BreakingBadApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
