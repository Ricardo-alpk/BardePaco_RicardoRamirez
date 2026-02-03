import 'package:flutter/material.dart';
import '../viewmodels/crear_pedido_vm.dart';
import '../models/item_pedido.dart';
import 'seleccionar_productos_pagina.dart';

/// Pantalla de formulario para iniciar un nuevo pedido.
///
/// Permite al usuario introducir el nombre de la mesa y navegar a
/// [SeleccionarProductosPagina] para añadir items.
class CrearPedidoPagina extends StatefulWidget {
  const CrearPedidoPagina({super.key});

  @override
  State<CrearPedidoPagina> createState() {
    return _CrearPedidoPaginaState();
  }
}

class _CrearPedidoPaginaState extends State<CrearPedidoPagina> {
  /// ViewModel que mantiene el estado temporal del pedido en construcción.
  final CrearPedidoVm vm = CrearPedidoVm();
  final TextEditingController controlador = TextEditingController();

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  /// Navega a la pantalla de selección de productos pasando los items actuales.
  Future<void> irASeleccionar() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SeleccionarProductosPagina(
            itemsIniciales: vm.itemsSeleccionados,
          );
        },
      ),
    );

    if (!mounted) {
      return;
    }

    if (resultado != null) {
      setState(() {
        vm.actualizarItems(resultado as List<ItemPedido>);
      });
    }
  }

  /// Navega a la pantalla de resumen solo si el pedido es válido.
  Future<void> verResumen() async {
    if (!vm.puedeGuardar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Primero escribe un nombre y añade productos"),
        ),
      );
      return;
    }

    await Navigator.pushNamed(
      context,
      '/resumen',
      arguments: vm.construirPedido(),
    );
  }

  /// Finaliza la creación del pedido y retorna el objeto [Pedido] a la pantalla anterior.
  void guardar() {
    if (!vm.puedeGuardar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Adónde vas, añade productos antes"),
        ),
      );
      return;
    }

    Navigator.pop(context, vm.construirPedido());
  }

  void cancelar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo pedido"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controlador,
              decoration: const InputDecoration(
                hintText: "Escribe el nombre de la mesa",
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) {
                setState(() {
                  vm.establecerMesa(valor);
                });
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              irASeleccionar();
            },
            child: const Text("Añadir productos"),
          ),

          ElevatedButton(
            onPressed: () {
            verResumen();
            },
            child: const Text("Ver resumen"),
          ),

          Expanded(
            child: Builder(
              builder: (context) {
                if (vm.itemsSeleccionados.isEmpty) {
                  return const Center(
                    child: Text("Veo que tienes FAME, Apura  Añade productos para comer"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: vm.itemsSeleccionados.length,
                    itemBuilder: (context, i) {
                      final item = vm.itemsSeleccionados[i];
                      return ListTile(
                        title: Text(item.producto.nombre),
                        subtitle: Text("Cantidad: ${item.cantidad}"),
                        trailing: Text("${item.subtotal.toStringAsFixed(2)} €"),
                      );
                    },
                  );
                }
              },
            ),
          ),

          Text(
            "Total: ${vm.totalPrecio.toStringAsFixed(2)} €",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    cancelar();
                  },
                  child: const Text("Cancelar"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    guardar();
                  },
                  child: const Text("Guardar pedido"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}