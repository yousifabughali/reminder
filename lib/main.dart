import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_second_project/db/create_db.dart';
import 'package:reminder_second_project/providers/change_dark.dart';
import 'package:reminder_second_project/providers/db_list_provider.dart';
import 'package:reminder_second_project/providers/db_reminder_provider.dart';
import 'package:reminder_second_project/views/screens/all_reminders_screen.dart';
import 'package:reminder_second_project/views/screens/home_screen.dart';
import 'package:reminder_second_project/views/screens/item_list_screen.dart';
import 'package:reminder_second_project/views/screens/scheduled.dart';
import 'package:reminder_second_project/views/screens/spalsh_screen.dart';
import 'package:reminder_second_project/views/screens/today_reminders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DbProvider().initDb();

  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/localization',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ReminderProvider>(
            create: (context) {
              return ReminderProvider();
            },
          ),
          ChangeNotifierProvider<ListProvider>(
            create: (context) {
              return ListProvider();
            },
          ),
          ChangeNotifierProvider<ChangeDark>(
            create: (context) {
              return ChangeDark();
            },
          ),
        ],
        builder:(context,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: '/',
            theme: Provider
                .of<ChangeDark>(context)
                .isDark ? ThemeData.dark() : ThemeData.light(),
            routes: {
              '/': (context) => SplashScreen(),
              '/HomeScreen': (context) => HomeScreen(),
              '/AllReminders': (context) => const AllRemindersScreen(),
              '/ScheduledReminders': (context) =>
              const ScheduledRemindersScreen(),
              '/TodayReminders': (context) => const TodayReminders(),
              // '/ScreenOfAnItem':(context) => ItemListScreen(),
            },
          );
        },
      ),
    );
  }
}