
import 'package:app_examenes/pages/view_rules.dart';
import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class Home extends StatefulWidget {
  static String routeName = 'view_Home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
// decoration: BoxDecoration(
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determinar el tamaño del dispositivo
          bool isMobile = constraints.maxWidth < 1000;

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
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: isMobile
                      ? _buildMobileLayout()
                      : _buildDesktopLayout(
                          context,
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Text(
                'FlutterHub es una aplicación de prueba para el curso de Flutter. puedes usarla para practicar y aprender teoría Flutter a base examenes de preguntas y respuestas',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Iniciar'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            'assets/logo_flutter.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Bienvenido a\n FlutterHub',
                  style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold, color: Colors.white, ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'FlutterHub es una aplicación de prueba para el curso de Flutter. puedes usarla para practicar y aprender teoría Flutter a base examenes de preguntas y respuestas',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 60),
                PrettySlideIconButton(
                  foregroundColor: Colors.cyan,
                
                  icon: Icons.arrow_forward,
                  label: '¡Empieza!',
                  slidePosition: SlidePosition.right,
                  labelStyle: Theme.of(context).textTheme.bodyLarge!,
                  onPressed: () {
                    Navigator.pushNamed(context, Rules.routeName);
                  },
                ),
                
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(80),
            child: Image.asset(
              'assets/icono5.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
