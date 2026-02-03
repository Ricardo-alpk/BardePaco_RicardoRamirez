import 'package:flutter/material.dart';
import '../models/pedido.dart';

/// Pantalla de solo lectura que muestra el detalle de un [Pedido].
///
/// Recibe el objeto pedido como argumento y desglosa sus items y totales.
class ResumenPedidoPagina extends StatelessWidget {
  final Pedido pedido;

  const ResumenPedidoPagina({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen del pedido"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          Text(
            "Mesa: ${pedido.mesa}",
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 10),

          const Text("Productos:"),

          Expanded(
            child: ListView.builder(
              itemCount: pedido.items.length,
              itemBuilder: (context, index) {
                final item = pedido.items[index];

                return ListTile(
                  title: Text(item.producto.nombre),
                  subtitle: Text("Cantidad: ${item.cantidad}"),
                  trailing: Text("${item.subtotal.toStringAsFixed(2)} €"),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Total: ${pedido.totalDePrecio.toStringAsFixed(2)} €",
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Volver"),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}