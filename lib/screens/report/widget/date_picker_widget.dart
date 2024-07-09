import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recything_mobile/constants/pallete.dart';

class DatePickerWidget extends StatefulWidget {
  final TextEditingController controller;
  const DatePickerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  TextEditingController dateInput = TextEditingController();
  bool isDateSelected = false;

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      controller: widget.controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Pallete.info),
        ),
        focusColor: Pallete.info,
        hintText: 'Tanggal',
      ),
      style: ThemeFont.bodySmallMedium.copyWith(
        color: isDateSelected ? Pallete.dark1 : Pallete.dark1,
        fontWeight: FontWeight.w500,
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

          setState(() {
            widget.controller.text = formattedDate;
            isDateSelected = true;
          });
        }
      },
    );
  }
}
