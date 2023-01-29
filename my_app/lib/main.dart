import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define un widget de formulario personalizado
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define la clase State correspondiente. Esta clase contendrá los datos relacionados con
// nuestro formulario.
class _MyCustomFormState extends State<MyCustomForm> {
  // Crea un controlador de texto. Lo usaremos para recuperar el valor actual
  // del TextField!
  final myController = TextEditingController();
  int _numPlayers = 0;

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
  }

  void setNumPlayers(value) {
    setState(() {
      _numPlayers = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number of players'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
                decoration:
                    const InputDecoration(hintText: "Enter num players"),
                keyboardType: TextInputType.number,
                controller: myController),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: myController,
              builder: (context, value, child) {
                return ElevatedButton(
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: value.text.isNotEmpty
                      ? () {
                          if (int.parse(myController.text) <= 50 &&
                              int.parse(myController.text) > 0) {
                            setNumPlayers(int.parse(myController.text));
                            print(_numPlayers);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    title: Text('Maxium num of players is 50!'),
                                    content: Text(
                                        'Introduce a num lower or equal to 50'),
                                  );
                                });
                          }
                        }
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
