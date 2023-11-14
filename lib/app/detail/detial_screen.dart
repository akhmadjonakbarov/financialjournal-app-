import 'package:financialjournal_app/app/detail/widgets/incomes_list.dart';
import 'package:financialjournal_app/app/detail/widgets/outlays_list.dart';
import 'package:financialjournal_app/utils/money_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  MoneyFormatter moneyFormatter = MoneyFormatter();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  'User!',
                  style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        height: 150,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Hisob',
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                '${moneyFormatter.formatter(data: 450000)} UZS',
                                style: GoogleFonts.nunito(
                                  fontSize: 28.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TabBar(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        labelStyle: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Creates border
                          color: Colors.black,
                        ),
                        unselectedLabelColor: Colors.black,
                        splashBorderRadius: BorderRadius.circular(10),
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
                      ))
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
