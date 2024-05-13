import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ListProfile extends StatefulWidget {
  List<dynamic> values = [
    {"name": "", "id": 0}
  ];
  Function onTap = () {};
  String selectevalue = "0";

  ListProfile(List<dynamic> val, Function Tap, String value) {
    this.values = val;
    this.onTap = Tap;
    this.selectevalue = value;
  }

  @override
  State<StatefulWidget> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  @override
  Widget build(BuildContext context) {
    if (widget.selectevalue == null || widget.selectevalue.isEmpty) {
      widget.selectevalue = "0";
    }

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                // elevation: widget.values.length,
                isExpanded: true,
                dropdownMaxHeight: 200,
                dropdownWidth: MediaQuery.of(context).size.width / 1.3,
                dropdownPadding: const EdgeInsets.all(10),
                hint: const Text('Выберите номинал'),
                value: widget.selectevalue,
                onChanged: (newValue) {
                  widget.onTap(newValue);
                  setState(() {
                    widget.selectevalue = newValue.toString();
                  });
                },
                items: widget.values.map((location) {
                  String text = location['name'];
                  return DropdownMenuItem(
                    child: SizedBox(
                      child: Text(
                        text,
                        style: const TextStyle(
                            color: Color(0xff7355AE),
                            fontSize: 14,
                            fontFamily: "Ubuntu-Light"),
                      ),
                    ),
                    value: location['id'].toString(),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
