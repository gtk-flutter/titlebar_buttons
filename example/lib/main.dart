import 'package:change_case/change_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:titlebar_buttons/titlebar_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = ValueNotifier<ThemeMode>(ThemeMode.system);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeMode,
      builder: (_, thMode, __) {
        return MaterialApp(
          title: 'Titlebar Buttons Demo',
          theme: ThemeData(
            primarySwatch: MaterialColor(
              Colors.grey[50]!.value,
              <int, Color>{
                50: Colors.grey[50]!,
                100: Colors.grey[50]!,
                200: Colors.grey[50]!,
                300: Colors.grey[50]!,
                400: Colors.grey[50]!,
                500: Colors.grey[50]!,
                600: Colors.grey[50]!,
                700: Colors.grey[50]!,
                800: Colors.grey[50]!,
                900: Colors.grey[50]!,
              },
            ),
            primaryColor: Colors.grey[200],
          ),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values
              .firstWhere((element) => element.index == thMode.index),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(themeMode: themeMode),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.themeMode}) : super(key: key);

  final ValueNotifier<ThemeMode> themeMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ThemeType _currentThemeType = ThemeType.auto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Started'),
        actions: [
          DecoratedMinimizeButton(
            type: _currentThemeType,
            onPressed: () => debugPrint('Minimize Window'),
          ),
          DecoratedMaximizeButton(
            type: _currentThemeType,
            onPressed: () => debugPrint('Maximize Window'),
          ),
          DecoratedCloseButton(
            type: _currentThemeType,
            onPressed: () => debugPrint('Close Window'),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<ThemeType>(
              value: _currentThemeType,
              items: ThemeType.values
                  .map(
                    (e) => DropdownMenuItem<ThemeType>(
                      value: e,
                      child: Text(describeEnum(e).toCapitalCase()),
                    ),
                  )
                  .toList(),
              onChanged: (thTy) {
                setState(() => _currentThemeType = thTy!);
              },
              selectedItemBuilder: (ctx) => ThemeType.values
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(describeEnum(e).toCapitalCase()),
                      ),
                    ),
                  )
                  .toList(),
              iconSize: 20,
              underline: const SizedBox(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.themeMode.value =
              Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.nightlight_round),
      ),
    );
  }
}
