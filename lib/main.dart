import 'package:flutter/material.dart';
import 'views/inicio_pagina.dart';
import 'views/resumen_pedido_pagina.dart';
import 'models/pedido.dart';

/// Punto de entrada de la aplicación.
void main() {
  runApp(const MyApp());
}

/// Widget raíz de la aplicación.
///
/// Configura el tema, las rutas de navegación y establece [InicioPagina] como home.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pedidos Bar",
      debugShowCheckedModeBanner: false,
      home: const InicioPagina(),

      // Definición de rutas con nombre para navegación
      routes: {
        /// Ruta para ver el resumen del pedido. Espera un argumento de tipo [Pedido].
        '/resumen': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          if (args == null || args is! Pedido) {
            // Manejo de error si los argumentos no son válidoss
            return const Scaffold(
              body: Center(
                child: Text("Error: Pedido no válido"),
              ),
            );
          }

          return ResumenPedidoPagina(pedido: args);
        },
      },
    );
  }
}