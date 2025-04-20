import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VolumeConverterPage extends StatefulWidget {
  const VolumeConverterPage({super.key});

  @override
  _VolumeConverterPageState createState() => _VolumeConverterPageState();
}

class _VolumeConverterPageState extends State<VolumeConverterPage> {
  String fromUnit = 'Liter';
  String toUnit = 'Milliliter';
  double result = 0.0;

  final TextEditingController inputController = TextEditingController();

  final List<String> volumeUnits = [
    'Liter',
    'Milliliter',
    'Cubic Meter',
    'Cubic Inch',
    'Gallon',
  ];
  final Map<String, String> shortUnits = {
    'Liter': 'L',
    'Milliliter': 'mL',
    'Cubic Meter': 'm³',
    'Cubic Inch': 'in³',
    'Gallon': 'gal',
  };

  void convertVolume() {
    double value = double.tryParse(inputController.text) ?? 0.0;

    final factors = {
      'Liter': 1.0,
      'Milliliter': 0.001,
      'Cubic Meter': 1000.0,
      'Cubic Inch': 0.0163871,
      'Gallon': 3.78541, // US gallon
    };

    setState(() {
      result = value * (factors[fromUnit]! / factors[toUnit]!);
    });
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
                          items: volumeUnits
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
                          items: volumeUnits
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
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: convertVolume,
                    child: Text('Convert', style: TextStyle(fontSize: 18.sp)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Result: ${result.toStringAsFixed(4)} ${shortUnits[toUnit]}',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
