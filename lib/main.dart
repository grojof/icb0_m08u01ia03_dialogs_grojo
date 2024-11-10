import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Recuperar el valor d\'un camp de text',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  /// Estil global per als botons
  final elevatedButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 24,
    ),
    backgroundColor: Colors.deepPurple[800],
    foregroundColor: Colors.white,
  );
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold principal de l'aplicació on es mostra tot el contingut
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar el valor d\'un camp de text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Fem Stack per mostrar els botons a la part inferior dreta
        child: Stack(
          children: [
            // TextField per a introduir el text que es mostra en en la
            // en cada modal
            TextField(
              controller: myController,
            ),
            // Encapsulem els botons en un Wrap per a que es mostrin en línia i facin wrap automàtic si cal
            Align(
              // Alineem el Wrap a la part inferior dreta
              alignment: Alignment.bottomRight,
              child: Wrap(
                spacing: 10, // Espai horitzontal entre els botons
                children: [
                  // Llistat de métodes que contenen els botons per mostrar
                  // els diferents modals amb el text introduït al TextField,
                  // passem el context
                  // per a poder mostrar els modals
                  _showModalBottomSheetButton(context),
                  _showSimpleDialogButton(context),
                  _showAlertDialogButton(context),
                  _showSnackBarButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Mostra un ModalBottomSheet amb el text introduït al TextField
  /// quan es prem el botó
  Widget _showModalBottomSheetButton(BuildContext context) {
    return ElevatedButton(
      style: elevatedButtonStyle,
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: const Color(0xFF4907FF),
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              height: 200,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      myController.text,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 80),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Tancar ModalBottomSheet'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Text('showModalBottomSheet'),
    );
  }

  /// Mostra un SimpleDialog amb el text introduït al TextField
  /// quan es prem el botó
  Widget _showSimpleDialogButton(BuildContext context) {
    return ElevatedButton(
      style: elevatedButtonStyle,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text(
                myController.text,
                textAlign: TextAlign.center,
              ),
              titlePadding: const EdgeInsets.only(
                top: 40,
                left: 40,
                right: 40,
                bottom: 20,
              ),
              contentPadding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 40,
              ),
              children: <Widget>[
                const Text('Això és un SimpleDialog mostrar amb un showDialog'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tancar SimpleDialog'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('SimpleDialog'),
    );
  }

  /// Mostra un AlertDialog amb el text introduït al TextField
  /// quan es prem el botó
  Widget _showAlertDialogButton(BuildContext context) {
    return ElevatedButton(
      style: elevatedButtonStyle,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('AlertDialog'),
              content: Text(myController.text),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tancar AlertDialog'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('AlertDialog'),
    );
  }

  /// Mostra un SnackBar amb el text introduït al TextField
  /// quan es prem el botó
  Widget _showSnackBarButton(BuildContext context) {
    return ElevatedButton(
      style: elevatedButtonStyle,
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(myController.text),
            action: SnackBarAction(
              label: 'Tancar',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      },
      child: const Text('SnackBar'),
    );
  }
}
