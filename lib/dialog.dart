import 'package:counter_app/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({
    super.key,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  var countController = TextEditingController();
  var maxController = TextEditingController();

  @override
  void dispose() {
    countController.dispose();
    maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var countState = context.watch<CounterState>();

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
    Widget colorBox(
      Color color,
    ) =>
        InkWell(
          onTap: () {
            countState.setCountColor(color);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: color,
                border: countState.countColor == color
                    ? Border.all(color: theme.colorScheme.primary, width: 3)
                    : null,
                borderRadius: BorderRadius.circular(5)),
          ),
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
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            countState
                                .setCount(value != "" ? int.parse(value) : 0);
                          },
                          controller: countController
                            ..text = countState.count.toString(),
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
                            value: countState.limit,
                            onChanged: (bool value) {
                              countState.setLimit(value);
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
                              readOnly: countState.limit == false,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                countState.setMax(
                                    value != "" ? int.parse(value ?? "0") : 0);
                              },
                              controller: maxController
                                ..text = countState.max.toString(),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: !countState.limit
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.primary,
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
                  children: colors.map(colorBox).toList(),
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
