import 'package:converter_app/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// class UnitConverterApp extends StatelessWidget {
//   const UnitConverterApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           filled: true,
//           fillColor: Colors.indigo.shade50,
//         ),
//         textTheme: TextTheme(
//           titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           bodyLarge: TextStyle(fontSize: 18),
//         ),
//       ),
//       home: UnitConverterHome(),
//     );
//   }
// }

// class UnitConverterHome extends StatefulWidget {
//   const UnitConverterHome({super.key});

//   @override
//   UnitConverterHomeState createState() => UnitConverterHomeState();
// }

// class UnitConverterHomeState extends State<UnitConverterHome> {
//   String selectedCategory = 'Length';
//   String fromUnit = 'Meter';
//   String toUnit = 'Kilometer';
//   double inputValue = 0.0;
//   double result = 0.0;

//   final TextEditingController inputController = TextEditingController();

//   final Map<String, List<String>> units = {
//     'Length': ['Meter', 'Kilometer', 'Mile', 'Inch', 'Foot'],
//     'Weight': ['Gram', 'Kilogram', 'Pound', 'Ounce'],
//     'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
//     'Volume': ['Litre', 'Millilitre', 'Gallon'],
//     'Area': ['Square Meter', 'Square Kilometer', 'Acre', 'Hectare'],
//   };

//   void convert() {
//     double value = double.tryParse(inputController.text) ?? 0.0;
//     setState(() {
//       switch (selectedCategory) {
//         case 'Length':
//           result = convertLength(value, fromUnit, toUnit);
//           break;
//         case 'Weight':
//           result = convertWeight(value, fromUnit, toUnit);
//           break;
//         case 'Temperature':
//           result = convertTemperature(value, fromUnit, toUnit);
//           break;
//         case 'Volume':
//           result = convertVolume(value, fromUnit, toUnit);
//           break;
//         case 'Area':
//           result = convertArea(value, fromUnit, toUnit);
//           break;
//       }
//     });
//   }

//   double convertLength(double value, String from, String to) {
//     final factors = {
//       'Meter': 1.0,
//       'Kilometer': 1000.0,
//       'Mile': 1609.34,
//       'Inch': 0.0254,
//       'Foot': 0.3048,
//     };
//     return value * (factors[from]! / factors[to]!);
//   }

//   double convertWeight(double value, String from, String to) {
//     final factors = {
//       'Gram': 1.0,
//       'Kilogram': 1000.0,
//       'Pound': 453.592,
//       'Ounce': 28.3495,
//     };
//     return value * (factors[from]! / factors[to]!);
//   }

//   double convertTemperature(double value, String from, String to) {
//     if (from == to) return value;
//     if (from == 'Celsius') {
//       if (to == 'Fahrenheit') return value * 9 / 5 + 32;
//       if (to == 'Kelvin') return value + 273.15;
//     } else if (from == 'Fahrenheit') {
//       if (to == 'Celsius') return (value - 32) * 5 / 9;
//       if (to == 'Kelvin') return (value - 32) * 5 / 9 + 273.15;
//     } else if (from == 'Kelvin') {
//       if (to == 'Celsius') return value - 273.15;
//       if (to == 'Fahrenheit') return (value - 273.15) * 9 / 5 + 32;
//     }
//     return value;
//   }

//   double convertVolume(double value, String from, String to) {
//     final factors = {
//       'Litre': 1.0,
//       'Millilitre': 0.001,
//       'Gallon': 3.78541,
//     };
//     return value * (factors[from]! / factors[to]!);
//   }

//   double convertArea(double value, String from, String to) {
//     final factors = {
//       'Square Meter': 1.0,
//       'Square Kilometer': 1e6,
//       'Acre': 4046.86,
//       'Hectare': 10000.0,
//     };
//     return value * (factors[from]! / factors[to]!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: Text('Unit Converter'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   DropdownButton<String>(
//                     isExpanded: true,
//                     value: selectedCategory,
//                     items: units.keys
//                         .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCategory = value!;
//                         fromUnit = units[selectedCategory]![0];
//                         toUnit = units[selectedCategory]![1];
//                       });
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   TextField(
//                     controller: inputController,
//                     decoration: InputDecoration(labelText: 'Enter value'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: DropdownButton<String>(
//                           isExpanded: true,
//                           value: fromUnit,
//                           items: units[selectedCategory]!
//                               .map((e) =>
//                                   DropdownMenuItem(value: e, child: Text(e)))
//                               .toList(),
//                           onChanged: (value) =>
//                               setState(() => fromUnit = value!),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Icon(Icons.swap_horiz, size: 30),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: DropdownButton<String>(
//                           isExpanded: true,
//                           value: toUnit,
//                           items: units[selectedCategory]!
//                               .map((e) =>
//                                   DropdownMenuItem(value: e, child: Text(e)))
//                               .toList(),
//                           onChanged: (value) => setState(() => toUnit = value!),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                     onPressed: convert,
//                     child: Text('Convert', style: TextStyle(fontSize: 18)),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             Center(
//               child: Text(
//                 'Result: ${result.toStringAsFixed(4)} $toUnit',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
