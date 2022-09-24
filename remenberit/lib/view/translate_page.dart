import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remenberit/controllers/main_controller.dart';
import 'package:remenberit/constants/colors.dart';
import 'package:translator/translator.dart';

import '../constants/open_glosbe.dart';
import '../utils/dimensions.dart';
import '../widgets/input_form.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({Key? key}) : super(key: key);

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final _textController = TextEditingController();
  final _translatedController = TextEditingController();
  String _fromLanguage = 'English';
  String _toLanguage = 'Arabic';
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Portuguese',
    'Russian',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
    'Turkish',
  ];

  final Map<String, String> _languagesAbv = {
    'English': 'en',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
    'Italian': 'it',
    'Portuguese': 'pt',
    'Russian': 'ru',
    'Chinese': 'zh',
    'Japanese': 'ja',
    'Korean': 'ko',
    'Arabic': 'ar',
    'Turkish': 'tr',
  };

  bool showSeeMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          // 70% of screen width and height
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.85,
          child: Card(
            elevation: 30,
            color: Colors.grey,
            margin: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                // translation page with a text field and button and text to show the translation
                children: <Widget>[
                  SizedBox(
                    height: Dimensions.getDVsize(20),
                  ),
                  // a text that says "from" and a drop down menu to select the language
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'From',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _fromLanguage,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            _fromLanguage = newValue!;
                          });
                        },
                        // todo: add the language that the user choses to the top
                        items: _languages
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                  // the TextField
                  TranslationField(
                    language: _fromLanguage,
                    controller: _textController,
                    readOnly: false,
                    color: AppColors.translateFromColor,
                  ),
                  // BUTTON to translate the text
                  ElevatedButton(
                    child: const Text('Translate'),
                    onPressed: () async {
                      _translatedController.text = "translating...";
                      // translate the text using google translation APi
                      var translation = await _textController.text.translate(
                          from: _languagesAbv[_fromLanguage]!,
                          to: _languagesAbv[_toLanguage]!);
                      _translatedController.text = translation.text;
                      showSeeMore = true;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: Dimensions.getDVsize(20),
                  ),
                  // to and drop down menu to select the target language
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'to',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _toLanguage,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            _toLanguage = newValue!;
                          });
                        },
                        // todo: add the language that the user choses to the top
                        items: _languages
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                  // show the translation
                  TranslationField(
                    readOnly: true,
                    color: AppColors.mainColor,
                    language: _toLanguage,
                    controller: _translatedController,
                  ),
                  TextButton(
                    onPressed: () {
                      openGlosbe(
                        _languagesAbv[_fromLanguage]!,
                        _languagesAbv[_toLanguage]!,
                        _textController.text,
                      );
                    },
                    child: const Text("see more"),
                  ),
                  //  a button to add to flash cards
                  ElevatedButton(
                    onPressed: _translatedController.text == ""
                        ? null
                        : () {
                            if (_check()) {
                              Get.find<MainController>().addCard(
                                  "${_languagesAbv[_toLanguage]!}:${_translatedController.text}",
                                  "${_languagesAbv[_fromLanguage]!}:${_textController.text}");
                            }
                          },
                    child: const Text('add to flash cards'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _check() {
    if (_textController.text == "" || _translatedController.text == "") {
      Get.snackbar(
        'Error',
        'some fields are missing',
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
      return false;
    }
    return true;
  }
}

class TranslationField extends StatelessWidget {
  const TranslationField({
    Key? key,
    required String language,
    required TextEditingController controller,
    required bool readOnly,
    required Color color,
  })  : _language = language,
        _textController = controller,
        _readOnly = readOnly,
        _color = color,
        super(key: key);

  final bool _readOnly;
  final Color _color;
  final String _language;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InputForm(
        textAlignment: _language == "Arabic" ? TextAlign.right : TextAlign.left,
        readOnly: _readOnly,
        height: Dimensions.getDVsize(150),
        color: _color,
        controller: _textController,
      ),
      Positioned(
        top: 20,
        left: _language == "Arabic" ? 20 : null,
        right: _language == "Arabic" ? null : 20,
        // an Icon button to copy text to clipboard
        child: IconButton(
          icon: const Icon(Icons.content_copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: _textController.text));
            // show a snackBar copied to clipboard
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Copied to clipboard'),
            ));
          },
        ),
      ),
    ]);
  }
}
