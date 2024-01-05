import 'package:financialjournal_app/app/on_board/pages/statistics/controllers/month_report_bloc/month_report_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'month_tile.dart';

class MonthsList extends StatefulWidget {
  const MonthsList({super.key});

  @override
  State<MonthsList> createState() => _MonthsListState();
}

class _MonthsListState extends State<MonthsList> {
  int selectedMonth = 0;

  @override
  void didChangeDependencies() {
    setState(() {
      selectedMonth = DateTime.now().month;
    });
    context.read<MonthReportBloc>().add(
          GetMonthReportEvent(
            monthNumber: selectedMonth,
          ),
        );
    super.didChangeDependencies();
  }

  List months = [
    'Yanvar',
    'Fevral',
    'Mart',
    'Aprel',
    'May',
    'Iyun',
    'Iyul',
    'Avgust',
    'Sentabr',
    'Oktabr',
    'Noyabr',
    'Dekabr'
  ];

  void _selectMonth(int indexOfMonth) {
    setState(() {
      selectedMonth = indexOfMonth;
    });
    context.read<MonthReportBloc>().add(
          GetMonthReportEvent(
            monthNumber: selectedMonth,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        months.length,
        (index) {
          final month = months[index];
          return MonthTile(
            title: month,
            index: index + 1,
            isSelected: (selectedMonth == (index + 1)),
            onTap: (indexOfMonth) {
              _selectMonth(indexOfMonth);
            },
          );
        },
      ),
    );
  }
}
