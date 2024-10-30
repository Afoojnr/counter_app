import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Counter App",
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
              primary: Colors.white, secondary: Colors.black)
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)
          ),
      home: const CounterHomePage(),
    );
  }
}

class CounterHomePage extends StatelessWidget {
  const CounterHomePage({super.key});
  // static AppIcons(IconData icon) {}
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final countStyle = theme.textTheme.headlineLarge!.copyWith(fontSize: 180);
    //   final theme = Theme.of(context);
    // final style = theme.textTheme.bodyLarge!.copyWith(
    //   color: theme.color  Scheme.primary,
    // );
    Future<void> _showSettingsDialog() {
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
                onPressed: _showSettingsDialog,
                icon: Icon(
                  Icons.settings,
                  color: theme.colorScheme.primary,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.refresh,
                  color: theme.colorScheme.primary,
                ))
          ],
        ),
        Text(
          "20",
          style: theme.textTheme.headlineLarge!.copyWith(fontSize: 180),
        ),
        Column(
          children: [
            Column(
              children: [
                Text(
                  "-12",
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove,
                      size: 50,
                    )),
                IconButton.outlined(
                    onPressed: () {},
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

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({
    super.key,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  bool limits = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = <Color>[
      Colors.black,
      Colors.white,
      Colors.blue,
      Colors.red,
      Colors.grey,
      Colors.purple,
      Colors.green,
      Colors.yellow
    ];
    Widget colorBox(Color color, {bool selected = false}) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: color,
              border: selected
                  ? Border.all(color: theme.colorScheme.primary, width: 3)
                  : null,
              borderRadius: BorderRadius.circular(5)),
        );
    return Dialog.fullscreen(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Settings",
                style: theme.textTheme.displaySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.primary),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Set count = "),
                    SizedBox(
                        width: 60,
                        height: 30,
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: theme.colorScheme.primary,
                              contentPadding: const EdgeInsets.only(
                                left: 5,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.primary),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Limits Off / On "),
                        Switch(
                            activeColor: theme.colorScheme.secondary,
                            activeTrackColor: theme.colorScheme.primary,
                            value: limits,
                            onChanged: (bool value) {
                              setState(() {
                                limits = value;
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Maximum = "),
                        SizedBox(
                            width: 70,
                            height: 30,
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: theme.colorScheme.primary,
                                  contentPadding:
                                      const EdgeInsets.only(left: 5),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.primary),
                    borderRadius: BorderRadius.circular(5)),
                child: Wrap(
                  spacing: 30,
                  runSpacing: 20,
                  children: [
                    for (var color in colors) colorBox(color),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
