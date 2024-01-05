import 'widgets/kurs_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/custom_numberinput_formatter.dart';
import '../../../common/controllers/blocs/kurs/kurs_bloc.dart';
import '../../../detail/widgets/custom_app_bar.dart';

class KursScreen extends StatefulWidget {
  const KursScreen({
    super.key,
  });

  @override
  State<KursScreen> createState() => _KursScreenState();
}

class _KursScreenState extends State<KursScreen> {
  final _kursFormKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  Future<void> _selectDateAndTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  double kursValue = 0.0;

  void _saveKurs() async {
    bool isValid = _kursFormKey.currentState!.validate();
    if (isValid) {
      _kursFormKey.currentState!.save();
      context.read<KursBloc>().add(KursAddEvent(kurs: kursValue));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              text: 'USD-UZS',
              isBackButton: true,
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Sana:',
            //         style: GoogleFonts.nunito(
            //           fontSize: 20,
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       Ink(
            //         child: InkWell(
            //           onTap: () => _selectDateAndTime(),
            //           child: Text(
            //             selectedDate == null
            //                 ? "Sanani tanlash"
            //                 : dateFormatter(selectedDate!),
            //             style: GoogleFonts.nunito(
            //               fontSize: 20,
            //               fontWeight: FontWeight.w700,
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Form(
              key: _kursFormKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(),
                      width: MediaQuery.sizeOf(context).width * 0.72,
                      child: TextFormField(
                        inputFormatters: [CustomNumberInputFormatter()],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Kurs',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          String crn = value!.replaceAll(',', '');
                          kursValue = double.parse(int.parse(crn).toString());
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Iltimos qiymat kiriting';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: _saveKurs,
                      child: Text(
                        'Saqlash',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const KursList()
          ],
        ),
      ),
    );
  }
}
