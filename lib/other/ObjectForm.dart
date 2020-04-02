import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:intl/intl.dart';

class ObjectForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  ObjectForm(this.onSubmit);

  _ObjectFormState createState() => _ObjectFormState();
}

class _ObjectFormState extends State<ObjectForm>{

  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  
  void submitForm() {
    final title = titleController.text;
    final value = double.tryParse(this.valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || this.selectedDate == null) return;

    this.widget.onSubmit(title, value, this.selectedDate);

  }

  _ShowDatePicker () {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((DateTime pickedDate) {
      setState(() {
        this.selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: this.titleController,
              decoration: InputDecoration(labelText: 'Titulo'),
              onSubmitted: (_) => this.submitForm(),
            ),
            TextField(
              controller: this.valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true ),
              decoration: InputDecoration(labelText: "Valor (Kz\$)"),
              onSubmitted: (_) => this.submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(this.selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : "Data Selecionada: ${DateFormat('dd/MM/y').format(this.selectedDate)}"),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    onPressed: this._ShowDatePicker(),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Nova'
                  ),
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: this.submitForm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}