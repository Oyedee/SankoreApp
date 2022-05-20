import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sankore_app/data/controllers/provider_controller.dart';
import 'package:sankore_app/pages/contacts_page.dart';
import 'package:sankore_app/pages/posts_page.dart';
import 'package:sankore_app/pages/sankore_page.dart';
import 'package:sankore_app/pages/sms_page.dart';

import 'data/routes/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.lightBlue,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.black54),
          ),
        ),
        dark: ThemeData(
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey,
          primarySwatch: Colors.blueGrey,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          ),
        ),
        initial: AdaptiveThemeMode.system,
        builder: (theme, darkTheme) {
          return ChangeNotifierProvider<ProviderController>(
            create: (context) => ProviderController(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: theme,
              darkTheme: darkTheme,
              home: const SankorePage(),
              routes: {
                Routes.contactsPage: (BuildContext context) =>
                    const ContactsPage(),
                Routes.smsPage: (BuildContext context) => const SMSPage(),
                Routes.postsPage: (BuildContext context) => const PostPage(),
              },
            ),
          );
        });
  }
}
