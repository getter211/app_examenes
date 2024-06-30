// ignore_for_file: avoid_unnecessary_containers


import 'package:app_examenes/model/question.dart';
import 'package:app_examenes/pages/view_rules.dart';
import 'package:app_examenes/pages/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:app_examenes/utils/responsive.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Result extends StatefulWidget {
  static String routeName = 'view_Result';
  final List<Questions> questionsSuccess;
  final List<Questions> questionsFail;

  const Result(this.questionsSuccess, this.questionsFail, {super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/fondo.jpg'),
                    fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4), // Capa negra con opacidad del 50%
              ),
              Container(
                child: Center(child: _buildMobileLayout(resp, 1)),
              ),
            ],
          );
        },
      ),
    );
  }

  Container containerResult(String text, int nPregunta) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          MyTextClass(
            text: text,
            fontSize: 20,
            colorText: Colors.white,
            bold: true,
            maxLines: 3,
          ),
          const SizedBox(height: 5),
          MyTextClass(
            text: nPregunta.toString(),
            fontSize: 20,
            colorText: Colors.white,
            bold: true,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(Responsive resp, int nPregunta) {
    int r = widget.questionsSuccess.length;
    double w = resp.width <= 1000 ? resp.widthPercent(80) : resp.widthPercent(60);
    double h = resp.height <= 700 ? resp.heightPercent(80) : resp.heightPercent(60);
    double title = resp.width <= 1000 ? 14 : 35;
    double text = resp.width <= 1000 ? 10 : 20;
    String mensaje = r >= 10
        ? "¡Enhorabuena! Has superado el examen , eres un Genio😎"
        : (r >= 8 && r <= 9)
            ? "Que bien!!, Has superado el examen , Q crack 😅"
            : (r >= 5 && r <= 7)
                ? "Falta estudiar 🥱"
                : (r >= 1 && r <= 4)
                    ? "Falta estudiar aun mas ☹️"
                    : "Date de baja ☠️";
    String imagen = r >= 10
        ? 'assets/icono3.png'
        : (r >= 8 && r <= 9)
            ? 'assets/icono4.png'
            : (r >= 5 && r <= 7)
                ? 'assets/icono2.png'
                : (r >= 1 && r <= 4)
                    ? 'assets/icono6.png'
                    : 'assets/icono6.png';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF1C1E50),
              ),
              width: w,
              height: h,
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
                                  text: "FELICIDADES!!!",
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
                      text: "Haz finalizado el Examen",
                      fontSize: text,
                      colorText: Colors.white,
                      bold: true,
                      maxLines: 3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          imagen,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridRow(
                    rowSegments: 10,
                    children: <ResponsiveGridCol>[
                      ResponsiveGridCol(
                        xs: 5,
                        xl: 5,
                        md: 5,
                        lg: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: containerResult(
                              "Respuestas Correctas: ✅ ", widget.questionsSuccess.length),
                        ),
                      ),
                      ResponsiveGridCol(
                        xs: 5,
                        xl: 5,
                        md: 5,
                        lg: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: containerResult(
                              "Respuestas Incorrectas: ❌ ", widget.questionsFail.length),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextClass(
                          text: mensaje,
                          fontSize: title,
                          colorText: Colors.white,
                          bold: true,
                          maxLines: 3),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 20),
                              Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue[800],
                                  border: Border.all(color: Colors.blue.shade900),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextButton.icon(
                                  icon: const Icon(
                                    FontAwesomeIcons.caretRight,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, Rules.routeName);
                                  },
                                  label: const Text(
                                    "Volver a jugar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

