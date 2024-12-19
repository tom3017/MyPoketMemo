import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart'; // 로컬 데이터 초기화

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  int _counter = 0;
  DateTime _selectedDay = DateTime.now(); // 기본값은 현재 날짜
  DateTime _focusedDay = DateTime.now();  // 기본값은 현재 날짜

  // 패딩을 화면 높이에 맞게 동적으로 설정
  EdgeInsets getHeaderPadding(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double headerPaddingTop = screenHeight * 0.1; // 화면 높이의 10%로 설정
    return EdgeInsets.fromLTRB(0, headerPaddingTop, 0, 0);
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(); // 한글 로컬 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          locale: 'ko_KR', // 한글 로케일 설정
          daysOfWeekHeight: 100,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              if (selectedDay.month != _focusedDay.month) {
                _focusedDay = selectedDay;
              }
            });
          },
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
          rangeSelectionMode: RangeSelectionMode.toggledOff,
          onRangeSelected: (start, end, focusedDay) {
            // 구현 필요 시 추가
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronVisible: true,
            rightChevronVisible: true,
            headerPadding: getHeaderPadding(context), // 동적 패딩 적용
            titleTextStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
