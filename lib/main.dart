import 'package:contacts_and_dialer/provider/theme_provider.dart';
import 'package:contacts_and_dialer/views/screens/main_screen/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (
      BuildContext context,
      ThemeProvider themeProvider,
      Widget? child,
    ) {
      return ScreenUtilInit(
        designSize: Size(375, 812),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white
            ),
            scaffoldBackgroundColor: Colors.white,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          onGenerateRoute: _generateRoute,
        ),
      );
    });
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return CupertinoPageRoute(
          builder: (BuildContext context) => MainScreen(),
        );
    }
  }
}
