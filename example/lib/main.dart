import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_decorations/window_decorations.dart';

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
            title: 'Window Decoration Demo',
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
        });
  }
}

class MyHomePage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeMode;

  const MyHomePage({Key? key, required this.themeMode}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ThemeType _currentThemeType = ThemeType.yaru;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Started"),
        actions: [
          DecoratedMinimizeButton(
            type: _currentThemeType,
            onPressed: () {},
          ),
          DecoratedMaximizeButton(
            type: _currentThemeType,
            onPressed: () {},
          ),
          DecoratedCloseButton(
            type: _currentThemeType,
            onPressed: () {},
          ),
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
                      child: Text(describeEnum(e)),
                      value: e,
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
                          vertical: 4, horizontal: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(describeEnum(e))),
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
