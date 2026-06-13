import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class AttendanceFilterSheet extends StatefulWidget {
  const AttendanceFilterSheet({super.key});

  @override
  State<AttendanceFilterSheet> createState() => _AttendanceFilterSheetState();
}

class _AttendanceFilterSheetState extends State<AttendanceFilterSheet> {
  DateTimeRange? selectedDateRange;

  final List<String> sites = [
    'Main Campus',
    'Elementary Building',
    'High School Building',
    'Annex Campus',
  ];

  final List<String> accessPoints = [
    'Main Gate',
    'North Gate',
    'South Gate',
    'Faculty Entrance',
  ];

  final Set<String> selectedSites = {};
  final Set<String> selectedAccessPoints = {};
  final Set<String> selectedDirections = {};

  Future<void> _pickDateRange() async {
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
      initialDateRange: selectedDateRange,
    );

    if (result != null) {
      setState(() {
        selectedDateRange = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          const SizedBox(height: 12),

          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Attendance Filters',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const Divider(height: 32),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// DATE RANGE
                  const Text(
                    'Date Range',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  InkWell(
                    onTap: _pickDateRange,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyLight),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        selectedDateRange == null
                            ? 'Select Date Range'
                            : '${selectedDateRange!.start.toString().split(' ')[0]} → ${selectedDateRange!.end.toString().split(' ')[0]}',
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// SITE
                  const Text(
                    'Site',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: sites.map((site) {
                      final selected = selectedSites.contains(site);

                      return FilterChip(
                        label: Text(site),
                        selected: selected,
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              selectedSites.add(site);
                            } else {
                              selectedSites.remove(site);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  /// ACCESS POINT
                  const Text(
                    'Access Point',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: accessPoints.map((point) {
                      final selected = selectedAccessPoints.contains(point);

                      return FilterChip(
                        label: Text(point),
                        selected: selected,
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              selectedAccessPoints.add(point);
                            } else {
                              selectedAccessPoints.remove(point);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  /// DIRECTION
                  const Text(
                    'Direction',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('IN'),
                        selected: selectedDirections.contains('IN'),
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              selectedDirections.add('IN');
                            } else {
                              selectedDirections.remove('IN');
                            }
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('OUT'),
                        selected: selectedDirections.contains('OUT'),
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              selectedDirections.add('OUT');
                            } else {
                              selectedDirections.remove('OUT');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.greyLight)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedDateRange = null;
                        selectedSites.clear();
                        selectedAccessPoints.clear();
                        selectedDirections.clear();
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'dateRange': selectedDateRange,
                        'sites': selectedSites.toList(),
                        'accessPoints': selectedAccessPoints.toList(),
                        'directions': selectedDirections.toList(),
                      });
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
