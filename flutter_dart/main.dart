import 'package:flutter/material.dart'; // Importa la librería fundamental de UI de Flutter.

// El punto de entrada de la aplicación; ejecuta la app envuelta en un MaterialApp para usar temas y navegación.
void main() => runApp(const MaterialApp(home: SelectorColorReactivo()));

// Definición de un widget con estado (Stateful), necesario porque los colores cambiarán dinámicamente.
class SelectorColorReactivo extends StatefulWidget {
  const SelectorColorReactivo({super.key});

  @override
  State<SelectorColorReactivo> createState() => _SelectorColorReactivoState();
}

// La clase State donde reside la lógica y las variables que cambian.
class _SelectorColorReactivoState extends State<SelectorColorReactivo> {
  // Variables para almacenar los valores de los componentes RGB (0 a 255).
  double rojo = 100;
  double verde = 150;
  double azul = 200;

  @override
  Widget build(BuildContext context) {
    // Se calcula el color final combinando los valores actuales de los sliders.
    // .toInt() es necesario porque Color.fromRGBO pide enteros, pero el Slider usa doubles.
    Color colorActual = Color.fromRGBO(
      rojo.toInt(),
      verde.toInt(),
      azul.toInt(),
      1, // Opacidad total (1.0).
    );

    return Scaffold(
      backgroundColor: colorActual, // El fondo de la pantalla cambia según los sliders.
      
      appBar: AppBar(
        title: const Text('Reactividad con Colores'),
        // El color de la barra superior también se adapta con un toque de transparencia.
        backgroundColor: colorActual.withOpacity(0.8),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Círculo central que sirve como vista previa del color.
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: colorActual,
                shape: BoxShape.circle, // Le da la forma circular.
                boxShadow: [
                  BoxShadow(
                    color: colorActual.withOpacity(0.5),
                    blurRadius: 30, // Efecto de resplandor.
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40), // Espaciador vertical.
            
            // Tarjeta que muestra el código Hexadecimal del color.
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                // Convierte los valores R, G y B a base 16 (Hex) y asegura que tengan 2 dígitos.
                '#${rojo.toInt().toRadixString(16).padLeft(2, '0')}'
                '${verde.toInt().toRadixString(16).padLeft(2, '0')}'
                '${azul.toInt().toRadixString(16).padLeft(2, '0')}'.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorActual, // El texto también usa el color reactivo.
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Llamadas a la función personalizada para crear los 3 sliders (Rojo, Verde, Azul).
            _buildSlider('🔴 Rojo', rojo, Colors.red, (val) {
              setState(() => rojo = val); // setState notifica a Flutter que debe redibujar la UI.
            }),
            _buildSlider('🟢 Verde', verde, Colors.green, (val) {
              setState(() => verde = val);
            }),
            _buildSlider('🔵 Azul', azul, Colors.blue, (val) {
              setState(() => azul = val);
            }),
          ],
        ),
      ),
    );
  }

  // Función auxiliar para no repetir el código de los Sliders.
  Widget _buildSlider(String label, double value, Color color, Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etiqueta que muestra el nombre del color y su valor numérico actual.
          Text(
            '$label: ${value.toInt()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // El control deslizable propiamente dicho.
          Slider(
            value: value,
            min: 0,
            max: 255,
            activeColor: color, // El color de la "línea" del slider.
            onChanged: onChanged, // Ejecuta la función setState definida arriba.
          ),
        ],
      ),
    );
  }
}