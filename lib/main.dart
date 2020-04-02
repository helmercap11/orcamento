import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orcamento/models/object.dart';

import 'other/Chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor:  Colors.blueAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          button:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      home: HomePage(),

    );
  }
}

class HomePage extends StatefulWidget{
 @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<HomePage>{

  final List<Object> _object = [
    Object(
      id: 'obj1',
      title: 'Universidade 12/12',
      value: 60000.00,
      date: DateTime.now().subtract(Duration(days: 1))
    ),
    Object(
      id: 'obj2',
      title: 'Internet',
      value: 16000.00,
      date: DateTime.now().subtract(Duration(days: 2))
    ),
    Object(
      id: 'obj3',
      title: 'Transporte',
      value: 600.00,
      date: DateTime.now().subtract(Duration(days: 3))
    ),
  ];
  bool _showChhart = false;
  
  List<Object> get _recentObjects {
    return this._object.where((object) {
      return object.date.isAfter(DateTime.now().subtract(
        Duration(days: 5),
      ));
    });
  }

  void _addObject(String title, double value, DateTime date){
    final newObject = Object(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date
    );
   setState(() {
     this._object.add(newObject);
   });

   Navigator.of(this.context).pop();
  }
  
  void _deleteObject(String id) {
    setState(() {
      this._object.retainWhere((object) => object.id == id);
    });
  }

  void _openObjectFromModal(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ObjectFrom(this._addObject);
        });
  }

  @override
  Widget build(BuildContext context) {
   final appBar = AppBar(
     title: Text('Orçamento Pessola'),
     actions: <Widget>[
       IconButton(
           icon: Icon(Icons.add),
           onPressed: () => this._openObjectFromModal(context),
       )
     ],
   );

   final availableHeigth = MediaQuery.of(context).size.height -
    appBar.preferredSize.height -
    MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Mostrar Gráfico'),
                Switch(
                  value: this._showChhart,
                  onChanged: (value) {
                    setState(() {
                      this._showChhart = value;
                    });
                  },
                ),
              ],
            ),
            if(this._showChhart)
              Container(
                height: availableHeigth * 0.3,
                child: Chart(this._recentObjects),
              ),
            if(!this._showChhart)
              Container(
                height:  availableHeigth * 0.7,
                child: ObjectList(
                  this._object,
                  this._deleteObject,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => this._openObjectFromModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
