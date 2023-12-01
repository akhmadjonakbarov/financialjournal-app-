import 'package:financialjournal_app/app/detail/pages/widgets/show_account.dart';
import 'package:financialjournal_app/app/home/models/debtor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/money_formatter.dart';
import '../widgets/incomes_list.dart';
import '../widgets/outlays_list.dart';

class AccountPage extends StatelessWidget {
  DebtorModel debtor;

  AccountPage({super.key, required this.debtor});

  MoneyFormatter moneyFormatter = MoneyFormatter();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowAccount(sum_: 450000),
                      TabBar(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        labelStyle: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // Creates border
                          color: Colors.black,
                        ),

                        unselectedLabelColor: Colors.black,
                        splashBorderRadius: BorderRadius.circular(10),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            height: 80,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: const Icon(
                                    CupertinoIcons.arrow_down,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Kirimlar"),
                                    Text(
                                      "${moneyFormatter.formatter(data: 25000)} UZS",
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Tab(
                            height: 80,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: const Icon(
                                    CupertinoIcons.arrow_up,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Chiqimlar"),
                                    Text(
                                      "${moneyFormatter.formatter(data: 25000)} UZS",
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            IncomesList(),
                            OutlaysList(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
