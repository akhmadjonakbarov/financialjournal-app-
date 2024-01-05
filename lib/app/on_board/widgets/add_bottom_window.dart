import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/blocs/debtor/debtor_bloc.dart';

class AddDebtorBottomSheet extends StatefulWidget {
  const AddDebtorBottomSheet({
    super.key,
  });

  @override
  State<AddDebtorBottomSheet> createState() => _AddDebtorBottomSheetState();
}

class _AddDebtorBottomSheetState extends State<AddDebtorBottomSheet> {
  Map<String, dynamic> debtorData = {
    'name': '',
    'phone': '',
  };

  // flutter variables
  final _debtorAddFormKey = GlobalKey<FormState>();

  void _saveDebtor() async {
    bool isValid = _debtorAddFormKey.currentState!.validate();
    if (isValid) {
      _debtorAddFormKey.currentState!.save();
      context.read<DebtorBloc>().add(
            DebtorAddEvent(
              name: debtorData['name'],
              phone: debtorData['phone'],
            ),
          );
      _debtorAddFormKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    double modalHeight = MediaQuery.sizeOf(context).height * 0.28;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: modalHeight + MediaQuery.of(context).viewInsets.bottom,
      child: Form(
        key: _debtorAddFormKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ism",
              ),
              onChanged: (name) {
                debtorData['name'] = name;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Iltimos ism raqam kiriting!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: "+998",
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "+998 99 123 45 67",
              ),
              inputFormatters: [
                MaskedInputFormatter(
                  '+### ## ### ## ##',
                )
              ],
              onChanged: (phone) {
                String newPhone = phone.replaceAll('+998', '');
                newPhone = newPhone.replaceAll(' ', '');
                debtorData['phone'] = newPhone;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Iltimos telefon raqam kiriting!';
                } else if (value.length < 9) {
                  return 'Telefon raqam mos kelmadi!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Ink(
              width: double.infinity,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: InkWell(
                onTap: () {
                  _saveDebtor();
                },
                child: Align(
                  child: Text(
                    'Saqlash',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
