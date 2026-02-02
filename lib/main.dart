import 'package:flutter/material.dart';
import 'views/inicio_pagina.dart';
import 'views/resumen_pedido_pagina.dart';
import 'models/pedido.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pedidos Bar",
      debugShowCheckedModeBanner: false,
      home: const InicioPagina(),

      routes: {
        '/resumen': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          if (args == null || args is! Pedido) {
            //por si da error
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
