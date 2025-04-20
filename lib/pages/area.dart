import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AreaConverterPage extends StatefulWidget {
  const AreaConverterPage({super.key});

  @override
  _AreaConverterPageState createState() => _AreaConverterPageState();
}

class _AreaConverterPageState extends State<AreaConverterPage> {
  String fromUnit = 'Square Meter';
  String toUnit = 'Square Foot';
  double result = 0.0;

  final TextEditingController inputController = TextEditingController();

  final List<String> areaUnits = [
    'Square Meter',
    'Square Kilometer',
    'Square Foot',
    'Square Yard',
    'Acre',
  ];
  final Map<String, String> shortUnits = {
    'Square Meter': 'm²',
    'Square Kilometer': 'km²',
    'Square Foot': 'ft²',
    'Square Yard': 'yd²',
    'Acre': 'ac',
  };

  void convertArea() {
    double value = double.tryParse(inputController.text) ?? 0.0;

    final factors = {
      'Square Meter': 1.0,
      'Square Kilometer': 1e6,
      'Square Foot': 0.092903,
      'Square Yard': 0.836127,
      'Acre': 4046.86,
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
                          items: areaUnits
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
                          items: areaUnits
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
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    onPressed: convertArea,
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
            )
          ],
        ),
      ),
    );
  }
}
