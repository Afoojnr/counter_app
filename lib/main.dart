import 'package:counter_app/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter_app/counter_model.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterState(),
      child: MaterialApp(
        title: "Counter App",
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
                primary: Colors.white, secondary: Colors.black)),
        home: const CounterHomePage(),
      ),
    );
  }
}

class CounterHomePage extends StatelessWidget {
  const CounterHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var countState = context.watch<CounterState>();

    Future<void> showSettingsDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SettingsDialog();
          });
    }

    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.info,
                color: theme.colorScheme.primary,
              ),
            ),
            IconButton(
                onPressed: showSettingsDialog,
                icon: Icon(
                  Icons.settings,
                  color: theme.colorScheme.primary,
                )),
            IconButton(
                onPressed: () {
                  countState.refresh();
                },
                icon: Icon(
                  Icons.refresh,
                  color: theme.colorScheme.primary,
                ))
          ],
        ),
        Text(
          countState.count.toString(),
          style: theme.textTheme.headlineLarge!
              .copyWith(fontSize: 180, color: countState.countColor),
        ),
        Column(
          children: [
            Column(
              children: [
                Text(
                  countState.max.toString(),
                  style: theme.textTheme.headlineMedium!,
                ),
                Text("limit reached".toUpperCase(),
                    style: theme.textTheme.bodySmall!)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton.outlined(
                    onPressed: () {
                      countState.decrement();
                    },
                    icon: const Icon(
                      Icons.remove,
                      size: 50,
                    )),
                IconButton.outlined(
                    onPressed: () {
                      countState.increment();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 50,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    ))));
  }
}
