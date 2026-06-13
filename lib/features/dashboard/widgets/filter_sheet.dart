import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  final List<String> schools = [
    'Acme School',
    'North Campus',
    'Westview Academy',
    'Saint Mary School',
  ];

  final List<String> sites = ['Main Campus', 'North Campus', 'South Campus'];

  final List<String> accessPoints = [
    'Main Gate',
    'Gate A',
    'Gate B',
    'Gym Entrance',
    'Library Entrance',
  ];

  final Set<String> selectedSchools = {};
  final Set<String> selectedSites = {};
  final Set<String> selectedAccessPoints = {};

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .95,
      minChildSize: .60,
      maxChildSize: 1,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      'Filters',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedSchools.clear();
                          selectedSites.clear();
                          selectedAccessPoints.clear();
                        });
                      },
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildSection(
                      title: 'Schools',
                      items: schools,
                      selectedItems: selectedSchools,
                    ),

                    const SizedBox(height: 24),

                    _buildSection(
                      title: 'Sites',
                      items: sites,
                      selectedItems: selectedSites,
                    ),

                    const SizedBox(height: 24),

                    _buildSection(
                      title: 'Access Points',
                      items: accessPoints,
                      selectedItems: selectedAccessPoints,
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(top: BorderSide(color: AppColors.greyLight)),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          text:
                              'Apply (${selectedSchools.length + selectedSites.length + selectedAccessPoints.length})',
                          onPressed: () {
                            Navigator.pop(context, {
                              'schools': selectedSchools.toList(),
                              'sites': selectedSites.toList(),
                              'accessPoints': selectedAccessPoints.toList(),
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> items,
    required Set<String> selectedItems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 12),

        ...items.map(
          (item) => CheckboxListTile(
            value: selectedItems.contains(item),
            contentPadding: EdgeInsets.zero,
            title: Text(item),
            activeColor: AppColors.primary,
            onChanged: (selected) {
              setState(() {
                if (selected == true) {
                  selectedItems.add(item);
                } else {
                  selectedItems.remove(item);
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
