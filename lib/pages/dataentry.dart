// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'database_helper.dart';

// class DataEntryPage extends StatefulWidget {
//   @override
//   _DataEntryPageState createState() => _DataEntryPageState();
// }

// class _DataEntryPageState extends State<DataEntryPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _cashController = TextEditingController();
//   final TextEditingController _pixController = TextEditingController();
//   final TextEditingController _creditController = TextEditingController();
//   final TextEditingController _debitController = TextEditingController();
//   final TextEditingController _openingController = TextEditingController();
//   final TextEditingController _closureController = TextEditingController();
//   final TextEditingController _expenseNameController = TextEditingController();
//   final TextEditingController _expenseValueController = TextEditingController();

//   List<Map<String, dynamic>> _resources = [];
//   Map<String, dynamic>? _selectedResource;

//   @override
//   void initState() {
//     super.initState();
//     _loadResources();
//   }

//   Future<void> _loadResources() async {
//     Database db = await DatabaseHelper().database;
//     List<Map<String, dynamic>> resources = await db.query('tb_resources');
//     setState(() {
//       _resources = resources;
//     });
//   }

//   Future<void> _submitData() async {
//     if (_formKey.currentState!.validate()) {
//       int date = int.parse(_dateController.text);
//       double cash = double.parse(_cashController.text);
//       double pix = double.parse(_pixController.text);
//       double credit = double.parse(_creditController.text);
//       double debit = double.parse(_debitController.text);
//       double opening = double.parse(_openingController.text);
//       double closure = double.parse(_closureController.text);
//       double difference = closure - opening;

//       Database db = await DatabaseHelper().database;

//       await db.insert('tb_daily_balance', {
//         'date': date,
//         'cash': cash,
//         'pix': pix,
//       });

//       await db.insert('tb_card_movement', {
//         'date': date,
//         'credit': credit,
//         'debit': debit,
//       });

//       await db.insert('tb_register', {
//         'date': date,
//         'opening': opening,
//         'closure': closure,
//         'difference': difference,
//       });

//       if (_selectedResource != null) {
//         String expenseName = _expenseNameController.text;
//         double expenseValue = double.parse(_expenseValueController.text);

//         await db.insert('tb_expenses', {
//           'date': date,
//           'resource_id': _selectedResource!['id'],
//           'name': expenseName,
//           'value': expenseValue,
//         });
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Data saved successfully')),
//       );

//       _clearForm();
//     }
//   }

//   void _clearForm() {
//     _dateController.clear();
//     _cashController.clear();
//     _pixController.clear();
//     _creditController.clear();
//     _debitController.clear();
//     _openingController.clear();
//     _closureController.clear();
//     _expenseNameController.clear();
//     _expenseValueController.clear();
//     setState(() {
//       _selectedResource = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Data Entry'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _dateController,
//                 decoration: InputDecoration(labelText: 'Date (Unix timestamp)'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a date';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _cashController,
//                 decoration: InputDecoration(labelText: 'Cash'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter cash amount';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _pixController,
//                 decoration: InputDecoration(labelText: 'Pix'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter pix amount';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _creditController,
//                 decoration: InputDecoration(labelText: 'Credit'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter credit amount';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _debitController,
//                 decoration: InputDecoration(labelText: 'Debit'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter debit amount';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _openingController,
//                 decoration: InputDecoration(labelText: 'Opening'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter opening amount';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _closureController,
//                 decoration: InputDecoration(labelText: 'Closure'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter closure amount';
//                   }
//                   return null;
//                 },
//               ),
//               DropdownButtonFormField<Map<String, dynamic>>(
//                 value: _selectedResource,
//                 hint: Text('Select Resource'),
//                 items: _resources.map((resource) {
//                   return DropdownMenuItem<Map<String, dynamic>>(
//                     value: resource,
//                     child: Text(resource['name']),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedResource = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select a resource';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _expenseNameController,
//                 decoration: InputDecoration(labelText: 'Expense Name'),
//                 validator: (value) {
//                   if (_selectedResource != null && (value == null || value.isEmpty)) {
//                     return 'Please enter an expense name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _expenseValueController,
//                 decoration: InputDecoration(labelText: 'Expense Value'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (_selectedResource != null && (value == null || value.isEmpty)) {
//                     return 'Please enter an expense value';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitData,
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
