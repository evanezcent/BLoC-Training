import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/model/pet.dart';
import 'package:fire/pet_details.dart';
import 'package:fire/repository/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataRepository repository = DataRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return _buildList(context, snapshot.data.docs);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPet();
        },
        tooltip: 'Add Pet',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addPet() {
    AlertDialogWidget dialogWidget = AlertDialogWidget();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Add Pet"),
              content: dialogWidget,
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      Pet newPet = Pet(dialogWidget.petName,
                          type: dialogWidget.character);
                      repository.addPet(newPet);
                      Navigator.of(context).pop();
                    },
                    child: Text("Add")),
              ]);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final pet = Pet.fromSnapshot(snapshot);
    if (pet == null) {
      return Container();
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(pet.name == null ? "" : pet.name,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold))),
              _getPetIcon(pet.type)
            ],
          ),
          onTap: () {
            _navigate(BuildContext context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetDetails(pet),
                  ));
            }

            _navigate(context);
          },
          highlightColor: Colors.green,
          splashColor: Colors.blue,
        ));
  }

  Widget _getPetIcon(String type) {
    Widget petIcon;
    if (type == "cat") {
      petIcon = IconButton(
        icon: Icon(Icons.category),
        onPressed: () {},
      );
    } else if (type == "dog") {
      petIcon = IconButton(
        icon: Icon(Icons.ac_unit),
        onPressed: () {},
      );
    } else {
      petIcon = IconButton(
        icon: Icon(Icons.pets),
        onPressed: () {},
      );
    }
    return petIcon;
  }
}

class AlertDialogWidget extends StatefulWidget {
  String petName;
  String character = '';

  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter a Pet Name"),
            onChanged: (text) => widget.petName = text,
          ),
          RadioListTile(
            title: Text("Cat"),
            value: "cat",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
          RadioListTile(
            title: Text("Dog"),
            value: "dog",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
          RadioListTile(
            title: Text("Other"),
            value: "other",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() {
                widget.character = value;
              });
            },
          )
        ],
      ),
    );
  }
}
