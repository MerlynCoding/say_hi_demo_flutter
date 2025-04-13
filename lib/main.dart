import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(SayHiApp());

class SayHiApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SayHiHome(),
    );
    // ignore: dead_code
    throw UnimplementedError();
  }
}

class SayHiHome extends StatefulWidget {
  @override
  _SayHiHomeState createState() => _SayHiHomeState();
}

class _SayHiHomeState extends State<SayHiHome>{
  final FlutterTts fluttetts =FlutterTts();
  late stt.SpeechToText _speech;
  bool _isListening=false;
  String _text='press to record';

  void initState(){
    super.initState();
    _speech=stt.SpeechToText();
  }

  void _speak () async{
    await fluttetts.setLanguage("en-US");
    await fluttetts.setSpeechRate(0.5);
    await fluttetts.speak("hi ...");
  }
  void _listen() async{
    if (!_isListening){
      bool available = await _speech.initialize();
      if (available){
        setState(() => _isListening=true);
        _speech.listen(onResult:(result){
          setState(() {
            _text=result.recognizedWords;
          });
        });
      }else{
        _speech.stop();
        setState(() => _isListening=false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("voice assistant")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _speak,  child: Text("say hello..")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _listen, child: Text(_isListening?  "stop recording":"start recording"),
            ),
            SizedBox(height : 20),
            Text(
              _text,style: TextStyle(fontSize: 20),
            )
          ],
        )
        
      ),
    );
    // ignore: dead_code
    throw UnimplementedError();
  }
}