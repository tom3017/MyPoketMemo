import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart'; // 로컬 데이터 초기화

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  // 카운터 변수 (현재는 사용되지 않음)
  int _counter = 0;

  // 현재 선택된 날짜 (기본값: 오늘 날짜)
  DateTime _selectedDay = DateTime.now();

  // 현재 초점이 맞춰진 날짜 (기본값: 오늘 날짜)
  DateTime _focusedDay = DateTime.now();

  // 화면 높이에 따라 동적으로 헤더 패딩 계산
  EdgeInsets getHeaderPadding(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double headerPaddingTop = screenHeight * 0.1; // 화면 높이의 10%를 상단 패딩으로 설정
    return EdgeInsets.fromLTRB(0, headerPaddingTop, 0, 0);
  }

  @override
  void initState() {
    super.initState();
    // 한글 로케일 초기화 (날짜 및 월 이름을 한글로 표시하기 위해)
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TableCalendar(
          // 캘린더의 첫 번째 날짜 (2010년 10월 16일)
          firstDay: DateTime.utc(2010, 10, 16),

          // 캘린더의 마지막 날짜 (2030년 3월 14일)
          lastDay: DateTime.utc(2030, 3, 14),

          // 현재 초점이 맞춰진 날짜
          focusedDay: _focusedDay,

          // 캘린더 로케일 설정 (한글로 표시)
          locale: 'ko_KR',

          // 요일 높이 설정
          daysOfWeekHeight: 100,

          // 선택된 날짜를 정의 (현재 선택된 날짜와 같은지 확인)
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },

          // 날짜가 선택되었을 때의 동작
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              // 선택된 날짜가 현재 초점의 월과 다를 경우 초점 이동
              if (selectedDay.month != _focusedDay.month) {
                _focusedDay = selectedDay;
              }
            });
          },

          // 캘린더 페이지가 변경되었을 때의 동작
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },

          // 기간 선택 모드 설정 (현재는 비활성화)
          rangeSelectionMode: RangeSelectionMode.toggledOff,

          // 기간이 선택되었을 때의 동작 (현재는 비어 있음)
          onRangeSelected: (start, end, focusedDay) {
            // 필요 시 구현
          },

          // 헤더 스타일 설정
          headerStyle: HeaderStyle(
            // 포맷 버튼 비활성화 (월/주 버튼 표시 안 함)
            formatButtonVisible: false,

            // 헤더 타이틀을 중앙 정렬
            titleCentered: true,

            // 좌/우 화살표 표시 (월 이동 가능)
            leftChevronVisible: true,
            rightChevronVisible: true,

            // 동적으로 계산된 상단 패딩 적용
            headerPadding: getHeaderPadding(context),

            // 헤더 타이틀 스타일 (글꼴 크기, 굵기, 색상)
            titleTextStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          // 캘린더 스타일 설정
          calendarStyle: const CalendarStyle(
            // 오늘 날짜 장식 스타일 (검정색 원)
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
