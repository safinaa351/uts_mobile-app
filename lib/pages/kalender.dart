import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:jurusan_inggris/widgets/bottom_navbar.dart';
import 'package:intl/intl.dart';

// Define Event class
class Event {
  final String title;
  Event(this.title);
}

class KalenderPage extends StatefulWidget {
  const KalenderPage({Key? key}) : super(key: key);

  @override
  State<KalenderPage> createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<String> _months = [];
  String? _selectedMonth;
  Map<DateTime, List<Event>> events = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _initializeMonths();
    _initializeEvents();
    _selectedMonth = _getMonthYearText(_focusedDay);
  }

  void _initializeMonths() {
    _months = [];
    DateTime current = DateTime(2024, 8); // Awal kalender akademik
    DateTime lastAllowedDate = DateTime(2025, 12);
    while (current.isBefore(lastAllowedDate) ||
        (current.year == lastAllowedDate.year &&
            current.month == lastAllowedDate.month)) {
      _months.add(_getMonthYearText(current));
      current = DateTime(current.year, current.month + 1);
    }
  }

  String _getMonthYearText(DateTime date) {
    List<String> monthNames = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${monthNames[date.month - 1]} ${date.year}';
  }

  void _initializeEvents() {
    events[DateTime(2024, 8, 1)] = [Event('Mulai Perkuliahan')];
    events[DateTime(2024, 12, 15)] = [Event('Ujian Akhir Semester')];
    events[DateTime(2025, 1, 15)] = [Event('Libur Semester')];
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Widget _buildMonthDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedMonth,
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedMonth = newValue;
                List<String> parts = newValue.split(' ');
                String monthName = parts[0];
                int year = int.parse(parts[1]);

                List<String> monthNames = [
                  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
                  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
                ];
                int month = monthNames.indexOf(monthName) + 1;
                _focusedDay = DateTime(year, month);
              });
            }
          },
          items: _months.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEventsList() {
    final eventsToday = _getEventsForDay(_selectedDay);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (eventsToday.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text('Tidak ada acara pada hari ini'),
            )
          else
            ...eventsToday.map((event) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                '${DateFormat('dd MMMM yyyy').format(_selectedDay)} : ${event.title}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.deepOrange,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Center(
        child: Text(
          'Kalender Akademik\n2024/2025',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
    Widget build(BuildContext context) {
        return SingleChildScrollView(
            child: Column(
            children: [
                _buildHeader(),
                const SizedBox(height: 16),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    children: [
                    _buildMonthDropdown(),
                    const SizedBox(height: 16),
                    TableCalendar<Event>(
                        firstDay: DateTime(2024),
                        lastDay: DateTime(2025, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        calendarFormat: _calendarFormat,
                        eventLoader: _getEventsForDay,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        headerVisible: false,
                        calendarStyle: CalendarStyle(
                        markerDecoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                            color: Colors.deepOrange.withOpacity(0.5),
                            shape: BoxShape.circle,
                        ),
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            _selectedMonth = _getMonthYearText(focusedDay);
                        });
                        },
                        onPageChanged: (focusedDay) {
                        setState(() {
                            _focusedDay = focusedDay;
                            _selectedMonth = _getMonthYearText(focusedDay);
                        });
                        },
                        onFormatChanged: (format) {
                        setState(() {
                            _calendarFormat = format;
                        });
                        },
                    ),
                    const SizedBox(height: 16),
                    _buildEventsList(),
                    ],
                ),
                ),
                const SizedBox(height: 16),
            ],
            ),
        );
    }
}