import 'package:flutter/material.dart';

class CalendarFilterSheet extends StatefulWidget {
  const CalendarFilterSheet({super.key});

  @override
  State<CalendarFilterSheet> createState() => _CalendarFilterSheetState();
}

class _CalendarFilterSheetState extends State<CalendarFilterSheet> {
  final schools = ['Acme School', 'Westview Academy'];

  final selectedSchools = <String>{};

  bool showEvents = true;
  bool showAnnouncements = true;
  bool showAttendance = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .8,
        child: Column(
          children: [
            const SizedBox(height: 16),

            const Text(
              'Calendar Filters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const Divider(),

            Expanded(
              child: ListView(
                children: [
                  const ListTile(title: Text('Content Types')),

                  CheckboxListTile(
                    title: const Text('Events'),
                    value: showEvents,
                    onChanged: (value) {
                      setState(() {
                        showEvents = value!;
                      });
                    },
                  ),

                  CheckboxListTile(
                    title: const Text('Announcements'),
                    value: showAnnouncements,
                    onChanged: (value) {
                      setState(() {
                        showAnnouncements = value!;
                      });
                    },
                  ),

                  CheckboxListTile(
                    title: const Text('Attendance'),
                    value: showAttendance,
                    onChanged: (value) {
                      setState(() {
                        showAttendance = value!;
                      });
                    },
                  ),

                  const Divider(),

                  const ListTile(title: Text('Schools')),

                  ...schools.map(
                    (school) => CheckboxListTile(
                      title: Text(school),
                      value: selectedSchools.contains(school),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            selectedSchools.add(school);
                          } else {
                            selectedSchools.remove(school);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
