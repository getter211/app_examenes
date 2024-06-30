// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, unused_field

import 'dart:convert';

import 'package:app_examenes/model/question.dart';
import 'package:app_examenes/pages/view_game.dart';
import 'package:app_examenes/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Rules extends StatefulWidget {
  static String routeName = 'view_Rules';

  const Rules({super.key});

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  List<Questions> _questions = [];
  bool _isLoading = true;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/questions'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _questions = data.map((item) => Questions.fromJson(item)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load questions';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

// decoration: BoxDecoration(
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
                child: Center(child: _buildMobileLayout(resp)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(Responsive resp) {
    double w = resp.width <= 1000 ? resp.widthPercent(80) : resp.widthPercent(60);
    double h = resp.height <= 700 ? resp.heightPercent(80) : resp.heightPercent(60);
    double title = resp.width <= 1500 ? 14 : 35;
    double text = resp.width <= 800
        ? 10
        : resp.width <= 1500
            ? 16
            : 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF1C1E50),
                ),
                width: w,
                height: h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, right: 0, left: 40, bottom: 20),
                      // padding: const EdgeInsets.only(top: 20, right: 300, left: 40, bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            'Reglas del Juego',
                            style: TextStyle(
                                fontSize: title, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: resp.widthPercent(30),
                            child: Text(
                              'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original.',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: text, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: resp.widthPercent(30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Game(_questions)),
                              );
                            },
                            child: const Text('Iniciar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: -5,
                  child: SizedBox(
                    width: resp.widthPercent(30),
                    height: resp.heightPercent(30),
                    child: Image.asset('assets/icono1.png', fit: BoxFit.cover),
                    //
                    // child: Image.asset('assets/logo_flutter.png')
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
