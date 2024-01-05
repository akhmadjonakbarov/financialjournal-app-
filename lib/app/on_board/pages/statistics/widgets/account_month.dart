import 'package:financialjournal_app/app/on_board/pages/statistics/controllers/month_report_bloc/month_report_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/money_formatter.dart';

class AccountMonth extends StatefulWidget {
  const AccountMonth({
    super.key,
  });

  @override
  State<AccountMonth> createState() => _AccountMonthState();
}

class _AccountMonthState extends State<AccountMonth> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthReportBloc, MonthReportState>(
      builder: (context, state) {
        if (state.status.isInProgress) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.2),
            child: const CircularProgressIndicator(),
          );
        } else if (state.status.isSuccess) {
          return ShowMonthAccount(
            state: state,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class ShowMonthAccount extends StatelessWidget {
  ShowMonthAccount({super.key, required this.state});
  final MonthReportState state;

  final MoneyFormatter moneyFormatter = MoneyFormatter();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              'Hisob',
              style: GoogleFonts.nunito(fontSize: 20, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              '${moneyFormatter.formatter(data: state.account)} UZS',
              style: GoogleFonts.nunito(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 5,
            margin: const EdgeInsets.only(bottom: 5, top: 20),
            decoration: const BoxDecoration(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.down_arrow,
                        color: Colors.white,
                      ),
                      Text(
                        'Kirimlar',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    '${moneyFormatter.formatter(data: state.monthIncome)} UZS',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.up_arrow,
                        color: Colors.white,
                      ),
                      Text(
                        'Chiqimlar',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    '${moneyFormatter.formatter(data: state.monthOutlay)} UZS',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
