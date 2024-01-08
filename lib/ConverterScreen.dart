import 'package:flutter/material.dart';
import 'package:temperature_converter/units.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

String dropValue = Unit.C;
int c = 0;
List<double> result = [0.0, 0.0, 0.0];
TextEditingController _textEditingController = TextEditingController();

class _ConverterScreenState extends State<ConverterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Converter",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black,
                  ),
                  child: DropdownButton<String>(
                    elevation: 5,
                    isExpanded: true,
                    isDense: true,
                    padding: EdgeInsets.only(top: 16, left: 12, right: 12),
                    alignment: Alignment.center,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.white,
                    ),
                    dropdownColor: Colors.grey.shade800,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    value: dropValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropValue = newValue!;
                      });
                    },
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    items: Unit.unitName.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: InputText(dropValue)),
              Divider(
                color: Colors.black,
                thickness: 2,
                indent: 8,
                endIndent: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Text(
                    "UNITS",
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "VALUE",
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              Card(
                  elevation: 5,
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.grey,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1, color: Colors.black)),
                  child: AnsTile(AnsList()[0], c)),
              Card(
                  elevation: 5,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.all(8),
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1, color: Colors.black)),
                  child: AnsTile(AnsList()[1], c + 1)),
              Card(
                  elevation: 5,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.all(8),
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1, color: Colors.black)),
                  child: AnsTile(AnsList()[2], c + 2)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        CalculateResult(_textEditingController.text);
                      },
                      style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(5),
                          shadowColor:
                              MaterialStatePropertyAll(Colors.grey.shade600),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green.shade500)),
                      child: Text(
                        "calculate",
                        style: TextStyle(color: Colors.white, fontSize: 21),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _textEditingController.clear();
                        setState(() {});
                      },
                      style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(5),
                          shadowColor:
                              MaterialStatePropertyAll(Colors.grey.shade600),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.red.shade500)),
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white, fontSize: 21),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  TextFormField InputText(String value) {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: _textEditingController,
        textAlign: TextAlign.center,
        cursorOpacityAnimates: true,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            hintText: "Enter value in $value",
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))));
  }

  void CalculateResult(String s) {
    if (s.isEmpty) {
      result[0] = 0.0;
      result[1] = 0.0;
      result[2] = 0.0;
      return;
    }
    double value = double.parse(s);
    if (dropValue == Unit.C) {
      result[0] = (value * 9 / 5) + 32;
      result[1] = (value + 273.15);
      result[2] = (value + 9 / 5) + 491.67;
    } else if (dropValue == Unit.F) {
      result[0] = (value - 32) * 5 / 9;
      result[1] = result[0] + 273.15;
      result[2] = value + 459.67;
    } else if (dropValue == Unit.K) {
      result[0] = value - 273.15;
      result[1] = (value - 273.15) * 9 / 5 + 32;
      result[2] = value * 9 / 5;
    } else {
      result[0] = (value - 491.67) * 5 / 9;
      result[1] = value - 459.67;
      result[2] = value * 5 / 9;
    }
    result[0] = double.parse((result[0]).toStringAsFixed(2));
    result[1] = double.parse((result[1]).toStringAsFixed(2));
    result[2] = double.parse((result[2]).toStringAsFixed(2));
    setState(() {});
  }

  List<String> AnsList() {
    List<String> l = [Unit.C, Unit.F, Unit.K, Unit.R];
    l.remove(dropValue);
    return l;
  }

  ListTile AnsTile(String value, int i) {
    CalculateResult(_textEditingController.text);
    return ListTile(
      title: Text(
        value,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Text(
        "${result[i]}",
        style: TextStyle(fontSize: 18),
      ),
      tileColor: (i % 2 != 0) ? Colors.white : Colors.lightBlue.shade100,
      contentPadding: EdgeInsets.all(10),
    );
  }
}
