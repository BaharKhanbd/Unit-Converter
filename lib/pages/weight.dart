import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightConverterPage extends StatefulWidget {
  const WeightConverterPage({super.key});

  @override
  WeightConverterPageState createState() => WeightConverterPageState();
}

class WeightConverterPageState extends State<WeightConverterPage> {
  String fromUnit = 'Gram';
  String toUnit = 'Kilogram';
  double result = 0.0;

  final TextEditingController inputController = TextEditingController();

  final List<String> weightUnits = [
    'Gram',
    'Kilogram',
    'Pound',
    'Ounce',
    'Ton',
  ];
  final Map<String, String> shortUnits = {
    'Gram': 'g',
    'Kilogram': 'kg',
    'Pound': 'lb',
    'Ounce': 'oz',
    'Ton': 't',
  };

  void convertWeight() {
    double value = double.tryParse(inputController.text) ?? 0.0;

    final factors = {
      'Gram': 1.0,
      'Kilogram': 1000.0,
      'Pound': 453.592,
      'Ounce': 28.3495,
      'Ton': 1e6,
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
                          items: weightUnits
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
                          items: weightUnits
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: convertWeight,
                    child: Text('Convert', style: TextStyle(fontSize: 18.sp)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Center(
              child: Text(
                'Result: ${result.toStringAsFixed(4)} ${shortUnits[toUnit]}',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
