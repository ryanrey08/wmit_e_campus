import 'package:flutter/material.dart';

class AnnouncementFilterSheet extends StatefulWidget {
  const AnnouncementFilterSheet({super.key});

  @override
  State<AnnouncementFilterSheet> createState() =>
      _AnnouncementFilterSheetState();
}

class _AnnouncementFilterSheetState extends State<AnnouncementFilterSheet> {
  final schools = ['Acme School', 'Westview Academy', 'Saint Mary School'];

  final selected = <String>{};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter Schools',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...schools.map(
              (school) => CheckboxListTile(
                title: Text(school),
                value: selected.contains(school),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selected.add(school);
                    } else {
                      selected.remove(school);
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selected.toList());
              },
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
