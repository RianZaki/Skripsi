import 'package:flutter/material.dart';
import 'package:recything_mobile/constants/pallete.dart';

class CheckboxReportWidget extends StatefulWidget {
  final List<String> options;
  final Function(String?) onChanged;

  CheckboxReportWidget({
    required this.options,
    required this.onChanged,
  });

  @override
  _CheckboxReportWidgetState createState() =>
      _CheckboxReportWidgetState();
}

class _CheckboxReportWidgetState
    extends State<CheckboxReportWidget> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        return Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = option;
                      widget.onChanged(option);
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: _selectedOption == option
                            ? Pallete.main
                            : Pallete.dark3,
                      ),
                      color: _selectedOption == option
                          ? Pallete.main
                          : Colors.transparent,
                    ),
                    child: _selectedOption == option
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = option;
                      widget.onChanged(option);
                    });
                  },
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedOption == option
                          ? Pallete.main
                          : Pallete.dark3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        );
      }).toList(),
    );
  }
}
