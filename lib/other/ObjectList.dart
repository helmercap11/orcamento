import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orcamento/models/object.dart';


class ObjectList extends StatelessWidget {
  final List<Object> objects;
  final void Function (String) onRemove;

  ObjectList(this.objects, this.onRemove);
  @override
  Widget build(BuildContext context) {
    return this.objects.isEmpty
      ? Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Nada Cadastrado',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: Image.asset('',
              fit: BoxFit.cover,
              ),
            )
          ],
    )
        :ListView.builder(
          itemCount: this.objects.length,
      itemBuilder: (ctx, index) {
            final Object object = this.objects[index];
            return Card(
              elevation: 5,
              margin:  EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text("R\$${object.value}"),
                    ),
                  ),
                ),
                title: Text(
                  object.title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                 DateFormat('d MMM y').format(object.date),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => this.onRemove(object.id),
                  color:  Theme.of(context).errorColor,
                ),
              ),
            );
      }
    );

  }

}