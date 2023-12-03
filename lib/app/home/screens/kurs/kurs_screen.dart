import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/custom_date_formatter.dart';
import '../../../detail/widgets/custom_app_bar.dart';
import 'widgets/kurs_tile.dart';

class KursScreen extends StatefulWidget {
  KursScreen({
    super.key,
  });

  @override
  State<KursScreen> createState() => _KursScreenState();
}

class _KursScreenState extends State<KursScreen> {
  final _kursFormKey = GlobalKey<FormState>();

  DateTime? selectedDate = null;

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

  void _saveKurs() async {
    bool isValid = _kursFormKey.currentState!.validate();
    if (isValid) {
      _kursFormKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              text: 'USD-UZS',
              isBackButton: true,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sana:',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Ink(
                    child: InkWell(
                      onTap: () => _selectDateAndTime(),
                      child: Text(
                        selectedDate == null
                            ? "Sanani tanlash"
                            : dateFormatter(selectedDate!),
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Form(
              key: _kursFormKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.72,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Kurs',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Iltimos qiymat kiriting';
                          } else if (double.tryParse(value) == null) {
                            return 'Qiymat faqat sonlardan iborat bo\'lish kerak!';
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
            Expanded(
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                itemBuilder: (context, index) {
                  return KursTile();
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
