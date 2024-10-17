import 'package:flutter/material.dart';

class SortingDialogue extends StatefulWidget {
  final Function(String) onSelected;
  final String currentSortOption;

  const SortingDialogue({
    super.key,
    required this.onSelected,
    required this.currentSortOption,
  });

  @override
  State<SortingDialogue> createState() => _SortingDialogueState();
}

class _SortingDialogueState extends State<SortingDialogue> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.currentSortOption;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sort'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: const Text('All'),
            value: 'All',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value!;
              });
              widget.onSelected(value!);
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<String>(
            title: const Text('Age: Elder'),
            value: 'Elder',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value!;
              });
              widget.onSelected(value!);
              Navigator.of(context).pop();
            },
          ),
          RadioListTile(
            title: const Text('Age: Younger'),
            value: 'Younger',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value!;
              });
              widget.onSelected(value!);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
