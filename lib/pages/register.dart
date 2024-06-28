import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/app_state.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _cashController = TextEditingController();
  TextEditingController _pixController = TextEditingController();
  TextEditingController _creditController = TextEditingController();
  TextEditingController _debitController = TextEditingController();
  TextEditingController _openingController = TextEditingController();
  TextEditingController _closureController = TextEditingController();
  TextEditingController _gasController = TextEditingController();
  TextEditingController _potatoController = TextEditingController();

  late DateFormat dateFormat;

  late DateTime _datePosition;
  late double _cashBalance;
  late double _pixBalance;
  late double _credit;
  late double _debit;
  late double _opening;
  late double _closure;
  Map<String, double> _employeeExpenses = { };
  double _gas = 0;
  double _potato = 0;

  int get year => _datePosition.year;
  int get month => _datePosition.month;

  @override
  void initState() {
    super.initState();
    
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('pt_BR');
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (ct) {
        return Container(
          height: 250,
          color: Color.fromRGBO(223, 223, 223, 1),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now().add(Duration(days: -1)),
                  maximumDate: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _dateController.text = dateFormat.format(newDate);
                      _datePosition = newDate;
                    });
                  },
                )
              ),
              CupertinoButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                }
              )
            ],
          )
        );
      }
    );

    if (selectedDate != null) {
      _dateController.text = dateFormat.format(selectedDate);
      _datePosition = selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!
      .copyWith(color: Colors.black87)
      .apply(fontSizeFactor: 0.46);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Fechamento'),
        backgroundColor: Color.fromARGB(255, 174, 196, 164),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: 'Selecione uma data'
                ),
                onTap: () => selectDate(context),
                readOnly: true
              ),
              TextField(
                controller: _cashController,
                decoration: InputDecoration(
                  labelText: 'Dinheiro',
                  hintText: 'Saldo em dinheiro',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                onChanged: (value) => _cashBalance = double.tryParse(value.replaceFirst(',','.')) ?? 0,
              ),
              TextField(
                controller: _pixController,
                decoration: InputDecoration(
                  labelText: 'Pix',
                  hintText: 'Saldo em Pix',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                onChanged: (value) => _pixBalance = double.tryParse(value.replaceFirst(',','.')) ?? 0,
              ),
              TextField(
                controller: _creditController,
                decoration: InputDecoration(
                  labelText: 'Crédito',
                  hintText: 'Saldo total em crédito',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                onChanged: (value) => _credit = double.tryParse(value.replaceFirst(',','.')) ?? 0,
              ),
              TextField(
                controller: _debitController,
                decoration: InputDecoration(
                  labelText: 'Débito',
                  hintText: 'Saldo total em débito',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                onChanged: (value) => _debit = double.tryParse(value.replaceFirst(',','.')) ?? 0,
              ),
              TextField(
                controller: _openingController,
                decoration: InputDecoration(
                  labelText: 'Era',
                  hintText: 'Troco inicial no caixa',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                onChanged: (value) => _opening = double.tryParse(value.replaceFirst(',','.')) ?? 0,
              ),
              TextField(
                controller: _closureController,
                decoration: InputDecoration(
                  labelText: 'Ficou',
                  hintText: 'Troco final no caixa',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                onChanged: (value) => _closure = double.tryParse(value.replaceFirst(',','.')) ?? 0,
              ),
              TextField(
                controller: _gasController,
                decoration: InputDecoration(
                  labelText: 'Gás',
                  hintText: 'Gastos comprando gás',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                onChanged: (value) => _gas = double.tryParse(value.replaceFirst(',','.')) ?? 0,
              ),
              TextField(
                controller: _potatoController,
                decoration: InputDecoration(
                  labelText: 'Batata',
                  hintText: 'Gastos comprando batata',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.|,?\d{0,2}'))],
                onChanged: (value) => _potato = double.tryParse(value.replaceFirst(',','.')) ?? 0,
              ),
              SizedBox(height: 14,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async => await appState.insertBalance(
                      _datePosition,
                      _cashBalance,
                      _pixBalance,
                      _credit,
                      _debit,
                      _opening,
                      _closure,
                      _employeeExpenses,
                      _gas,
                      _potato
                    ),
                    child: Text('Salvar Fechamento')
                  ),
                ]
              ),
              SizedBox(height: 5),
            ]
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _cashController.dispose();
    super.dispose();
  }

}

class InputTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;

  InputTextField({
    required this.icon,
    required this.label,
    required this.hint
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: Icon(Icons.clear),
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder()
      )
    );
  }
}