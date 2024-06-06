// import 'package:contacts_and_dialer/provider/theme_provider.dart';
// import 'package:contacts_and_dialer/utils/route/routes.dart';
// import 'package:contacts_and_dialer/views/screens/main_screen/main_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (BuildContext context) => ThemeProvider(),
//       child: const App(),
//     ),
//   );
// }
//
// class App extends StatelessWidget {
//   const App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(builder: (
//       BuildContext context,
//       ThemeProvider themeProvider,
//       Widget? child,
//     ) {
//       return ScreenUtilInit(
//         designSize: Size(375, 812),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
//             scaffoldBackgroundColor: Colors.white,
//           ),
//           darkTheme: ThemeData.dark(),
//           themeMode: themeProvider.themeMode,
//           onGenerateRoute: _generateRoute,
//         ),
//       );
//     });
//   }
//
//   Route<dynamic> _generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       // case RouteName.contactInfoScreen:
//       //   return CupertinoPageRoute(
//       //     builder: (BuildContext context) =>
//       //         ContactInfoScreen(contact: settings.arguments as Contact),
//       //   );
//       default:
//         return CupertinoPageRoute(
//           builder: (BuildContext context) => MainScreen(),
//         );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Dialer'),
        ),
        body: DialerScreen(),
      ),
    );
  }
}

class DialerScreen extends StatefulWidget {
  @override
  _DialerScreenState createState() => _DialerScreenState();
}

class _DialerScreenState extends State<DialerScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter phone number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final phoneNumber = _controller.text;
              _launchDialer(phoneNumber);
            },
            child: Text('Call'),
          ),
        ],
      ),
    );
  }
}

void _launchDialer(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunch(launchUri.toString())) {
    await launch(launchUri.toString());
  } else {
    throw 'Could not launch $launchUri';
  }
}
