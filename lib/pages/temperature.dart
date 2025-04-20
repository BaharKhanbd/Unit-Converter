import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TemperatureConverterPage extends StatefulWidget {
  const TemperatureConverterPage({super.key});

  @override
  _TemperatureConverterPageState createState() =>
      _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  String fromUnit = 'Celsius';
  String toUnit = 'Fahrenheit';
  double result = 0.0;

  final TextEditingController inputController = TextEditingController();

  final List<String> temperatureUnits = [
    'Celsius',
    'Fahrenheit',
    'Kelvin',
  ];
  final Map<String, String> shortUnits = {
    'Celsius': '°C',
    'Fahrenheit': '°F',
    'Kelvin': 'K',
  };

  void convertTemperature() {
    double value = double.tryParse(inputController.text) ?? 0.0;
    double celsiusValue;

    // Convert input to Celsius first
    if (fromUnit == 'Celsius') {
      celsiusValue = value;
    } else if (fromUnit == 'Fahrenheit') {
      celsiusValue = (value - 32) * 5 / 9;
    } else if (fromUnit == 'Kelvin') {
      celsiusValue = value - 273.15;
    } else {
      celsiusValue = value;
    }

    // Convert Celsius to target unit
    if (toUnit == 'Celsius') {
      result = celsiusValue;
    } else if (toUnit == 'Fahrenheit') {
      result = (celsiusValue * 9 / 5) + 32;
    } else if (toUnit == 'Kelvin') {
      result = celsiusValue + 273.15;
    } else {
      result = celsiusValue;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.r,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: inputController,
                    decoration: InputDecoration(labelText: 'Enter value'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: fromUnit,
                          items: temperatureUnits
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => fromUnit = value!),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Icon(Icons.swap_horiz, size: 30.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: toUnit,
                          items: temperatureUnits
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) => setState(() => toUnit = value!),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 20.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: convertTemperature,
                    child: Text('Convert', style: TextStyle(fontSize: 18.sp)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Result: ${result.toStringAsFixed(2)} ${shortUnits[toUnit]}',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
