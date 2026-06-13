import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wmit_e_campus/core/theme/app_theme.dart';
import 'package:wmit_e_campus/features/dashboard/widgets/activity_item.dart';
import 'package:wmit_e_campus/features/my_students/widgets/my_student_card.dart';
import 'package:wmit_e_campus/models/attendance_log_model.dart';
import 'package:go_router/go_router.dart';

class MyStudentsScreen extends StatefulWidget {
  MyStudentsScreen({super.key});

  @override
  State<MyStudentsScreen> createState() => _MyStudentsScreenState();
}

class _MyStudentsScreenState extends State<MyStudentsScreen> {
  final Map<String, List<ActivityItem>> groupedLogs = {
    'March 10, 2024': [
      ActivityItem(
        name: 'Bo',
        studentId: 'STLMN-OP88',
        gate: 'LOGIN AT MAIN GATE',
        date: '08 Dec, 25',
        time: '08:00 AM',
      ),
      ActivityItem(
        name: 'Marry',
        studentId: 'STLMN-OP88',
        gate: 'LOGIN AT MAIN GATE',
        date: '08 Dec, 25',
        time: '08:00 AM',
      ),
    ],
    'March 09, 2024': [
      ActivityItem(
        name: 'Bo',
        studentId: 'STLMN-OP88',
        gate: 'LOGIN AT MAIN GATE',
        date: '08 Dec, 25',
        time: '08:00 AM',
      ),
      ActivityItem(
        name: 'Marry',
        studentId: 'STLMN-OP88',
        gate: 'LOGIN AT MAIN GATE',
        date: '08 Dec, 25',
        time: '08:00 AM',
      ),
    ],
  };
  DateTime? _dateFrom;
  DateTime? _dateTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppGradients.onboardingBackground,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _buildHeader(),

                    const SizedBox(height: 24),

                    _buildStudentFilter(),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _buildDateFilter(
                            title: 'Date from',
                            selectedDate: _dateFrom,
                            onSelected: (date) {
                              setState(() {
                                _dateFrom = date;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDateFilter(
                            title: 'Date from',
                            selectedDate: _dateTo,
                            onSelected: (date) {
                              setState(() {
                                _dateTo = date;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'NOTE: App only can show 1 month of attendance logs.',
                      style: TextStyle(
                        color: Color(0xFF777E90),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: AppTheme.themePoppins,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ...groupedLogs.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 16),

                          ...entry.value.map(
                            (log) => Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: ActivityCard(item: log),
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      );
                    }),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black12)],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2962FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Request a Log',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFCFCFD),
                        fontFamily: AppTheme.themePoppins,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/avatar/profile_picture.jpg'),
          ),
        ),

        const SizedBox(width: 16),

        const Expanded(
          child: Text(
            'Monica!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: AppTheme.themePoppins,
              height: 16 / 32,
              color: AppColors.registerTitle,
            ),
          ),
        ),

        IconButton(
          icon: const Icon(Icons.person_add_alt_1),
          onPressed: () {
            context.push('/add-subscription');
          },
        ),
      ],
    );
  }

  // Widget _buildStudentFilter() {
  //   return Container(
  //     padding: const EdgeInsets.all(18),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey.shade300),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: const [
  //               Text(
  //                 'Select Student',
  //                 style: TextStyle(fontWeight: FontWeight.w600),
  //               ),
  //               SizedBox(height: 4),
  //               Text('All'),
  //             ],
  //           ),
  //         ),
  //         const Icon(Icons.chevron_right),
  //       ],
  //     ),
  //   );
  // }

  String selectedStudent = 'All';

  TextStyle studentTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF23262F),
    fontFamily: AppTheme.themePoppins,
  );

  TextStyle selectedTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF777E90),
    fontFamily: AppTheme.themePoppins,
  );

  Widget _buildStudentFilter() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: _showStudentPicker,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Student', style: studentTextStyle),
                  const SizedBox(height: 4),
                  Text(selectedStudent),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  void _showStudentPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final students = ['All', 'Bo', 'Marry'];

        return ListView.builder(
          shrinkWrap: true,
          itemCount: students.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(students[index], style: studentTextStyle),
              onTap: () {
                setState(() {
                  selectedStudent = students[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDateFilter({
    required String title,
    required DateTime? selectedDate,
    required Function(DateTime) onSelected,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          onSelected(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedDate == null
                        ? 'All'
                        : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
