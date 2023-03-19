import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();

  Speak() async{
    var translation = await translator.translate("This is me", to: 'hi-IN');
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(2.0);
    await flutterTts.speak('This is me');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Speak(),
      ),
    );
  }
}
