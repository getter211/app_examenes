// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, unused_field

import 'dart:async';
import 'dart:math';

import 'package:app_examenes/model/question.dart';
import 'package:app_examenes/pages/view_result.dart';
import 'package:app_examenes/pages/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:app_examenes/utils/responsive.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';
import 'package:pretty_animated_buttons/widgets/pretty_wave_button.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Game extends StatefulWidget {
  static String routeName = 'view_Game';
  final List<Questions> questions;

  const Game(this.questions, {super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late Responsive _resp;
  double _containerWidth = 0;
  late Timer _timer;
  int _countdown = 15;
  late Timer _timer2;
  bool start = true;
  double restWidth = 0;
  Color _barColor = Colors.green;
  late List<Questions> _randomQuestions;
  final List<Questions> _questionsSuccess = [];
  final List<Questions> _questionsFail = [];
  int _currentQuestionIndex = 0;
  bool _showAnswers = false;
  int miliseconds = 14000;
  bool finish = false;
  bool saveResult = true;

  @override
  void initState() {
    super.initState();
    _randomQuestions = _getRandomQuestions(widget.questions, 10);
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer2.cancel();
    super.dispose();
  }

  List<Questions> _getRandomQuestions(List<Questions> questions, int count) {
    final random = Random();
    final List<Questions> copy = List.from(questions);
    copy.shuffle(random);
    return copy.take(count).toList();
  }

  //! Funcion para iniciar la animacion y cambiar el tamaño de la barra
  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      setState(() {
        if (_containerWidth > 0) {
          //! CAMBIAR EL TAMANO DE LA BARRA
          _containerWidth -= restWidth;
        }

        ///! CAMBIAR EL COLOR DE LA BARRA
        if (_timer.tick >= 10) {
          _barColor = Colors.red;
        } else if (_timer.tick >= 5) {
          _barColor = Colors.orange;
        }
      });
    });
  }

  //! Funcipn para calcular el Temporizador
  void _startCountdown() {
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          //_timer.cancel();
          _timer2.cancel();
          _showAnswers = true;
          Future.delayed(const Duration(seconds: 1), () {
            _nextQuestion();
          });
        }
      });
    });
  }

  void _nextQuestion() {
    //_timer.cancel(); // Detener el temporizador cuando llegue a cero
    _timer2.cancel();
    start = true;
    setState(() {
      if (_currentQuestionIndex < _randomQuestions.length - 1) {
        saveResult = true;
        _currentQuestionIndex++;
      } else {
        finish = true;
        start = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    _resp = resp;
    if (start) {
      _containerWidth = resp.width.clamp(0.0, double.infinity); // Ensure non-negative width
      _barColor = Colors.green;
      _countdown = 15;
      miliseconds = 300;
      setState(() {
        _showAnswers = false;
        restWidth = (resp.width / 15); // Ensure non-negative restWidth
      });
    }

    if (_containerWidth == resp.width && start) {
      start = false;
      _barColor = Colors.green;
      _countdown = 15;
      miliseconds = 500;

      setState(() {});
      Future.delayed(const Duration(seconds: 1), () {
        miliseconds = 14000;
        _startCountdown();
        // _startAnimation();
      });
    }
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/fondo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              const SizedBox(
                height: 35,
              ),
              Visibility(
                visible: !finish,
                child: Positioned(
                  top: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.stopwatch, color: Colors.white, size: 30),
                          Text(_countdown.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 30)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(child: _buildMobileLayout(resp, _currentQuestionIndex + 1)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(Responsive resp, int nPregunta) {
    Questions currentQuestion = _randomQuestions[_currentQuestionIndex];

    double title = resp.width <= 1000 ? 14 : 35;
    double text = resp.width <= 1000 ? 10 : 20;

    // Asegúrate de que el texto no sea nulo
    return finish
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF1C1E50),
                        ),
                        width: resp.widthPercent(80),
                        height: resp.heightPercent(80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Examen Finalizado \n Ver su resultados",
                                style: TextStyle(color: Colors.white, fontSize: title),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: 300,
                              width: 300,
                              child: Image.asset(
                                'assets/icono5.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible: true,
                                        child: PrettyWaveButton(
                                          child: const Text(
                                            'Resultados',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Result(_questionsSuccess, _questionsFail)),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ])
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF1C1E50),
                      ),
                      width: resp.widthPercent(80),
                      height: resp.heightPercent(80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveGridRow(
                            rowSegments: 12,
                            children: <ResponsiveGridCol>[
                              ResponsiveGridCol(
                                  md: 12,
                                  lg: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyTextClass(
                                          text: "Pregunta $nPregunta",
                                          fontSize: text,
                                          colorText: Colors.white,
                                          bold: true,
                                          maxLines: 3,
                                        ),
                                        MyTextClass(
                                          text: " $nPregunta/10",
                                          fontSize: text,
                                          colorText: Colors.white,
                                          bold: true,
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: MyTextClass(
                              text: currentQuestion.question_text ?? "",
                              fontSize: text,
                              colorText: Colors.white,
                              bold: true,
                              maxLines: 3,
                            ),
                          ),
                          ResponsiveGridRow(
                            rowSegments: 12,
                            children: currentQuestion.answers!
                                .asMap()
                                .entries
                                .map((entry) => ResponsiveGridCol(
                                      xs: 6,
                                      xl: 6,
                                      md: 6,
                                      lg: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: ColorChangingButton(
                                          tapSaveResult: (value) {
                                            if (saveResult && _showAnswers && value != 1) {
                                              value == 2
                                                  ? _questionsSuccess.add(currentQuestion)
                                                  : value == 3
                                                      ? _questionsFail.add(currentQuestion)
                                                      : null;
                                              saveResult = false;
                                            }
                                          },
                                          tap: () {
                                            setState(() {
                                              _showAnswers = true;
                                            });
                                            Future.delayed(const Duration(seconds: 1), () {
                                              _nextQuestion();
                                              _showAnswers = false;
                                            });
                                          },
                                          initialState: _showAnswers
                                              ? entry.value.is_correct
                                                  ? 2
                                                  : 3
                                              : 0,
                                          text: entry.value.qnswer_text ?? '',
                                          onChangeColor: (int newState) {
                                            return _showAnswers
                                                ? (entry.value.is_correct ? 2 : 3)
                                                : 1;
                                          },
                                          showAnswers: _showAnswers,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
//! CAMBIAR EL COLOR DE LAS RESPUESTAS

class ColorChangingButton extends StatefulWidget {
  final Function(int) tapSaveResult;
  final Function() tap;
  final int initialState;
  final int Function(int) onChangeColor;
  final String text;
  final bool _showAnswers = false;

  ColorChangingButton(
      {required this.tapSaveResult,
      required this.tap,
      this.initialState = 1,
      required this.onChangeColor,
      required this.text,
      required bool showAnswers})
      : super();

  @override
  _ColorChangingButtonState createState() => _ColorChangingButtonState();
}

class _ColorChangingButtonState extends State<ColorChangingButton> {
  late int currentState;

  @override
  void initState() {
    super.initState();
    currentState = widget.initialState;
  }

  void validateAndChangeColor() {
    setState(() {
      if (!widget._showAnswers) {
        widget.tapSaveResult(currentState);
        currentState = widget.onChangeColor(currentState);
      } else {
        currentState = widget.initialState;
      }

      widget.tap();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget._showAnswers) {
      widget.tapSaveResult(currentState);
      currentState = widget.onChangeColor(currentState);
    } else {
      widget.tapSaveResult(currentState);
      currentState = widget.initialState;
    }
    Color buttonColor = Colors.grey;

    switch (currentState) {
      case 1:
        buttonColor = Colors.grey;
        break;
      case 2:
        buttonColor = Colors.green;
        break;
      case 3:
        buttonColor = Colors.red;
        break;
    }

    return GestureDetector(
      onTap: validateAndChangeColor,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
