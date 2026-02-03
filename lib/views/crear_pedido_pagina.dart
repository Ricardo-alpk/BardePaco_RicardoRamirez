import 'package:flutter/material.dart';
import '../viewmodels/crear_pedido_vm.dart';
import '../models/item_pedido.dart';
import 'seleccionar_productos_pagina.dart';

/// Pantalla de formulario para iniciar un nuevo pedido.
///
/// Incluye validaciones visuales, tooltips de ayuda y feedback mediante Snackbars.
class CrearPedidoPagina extends StatefulWidget {
  const CrearPedidoPagina({super.key});

  @override
  State<CrearPedidoPagina> createState() {
    return _CrearPedidoPaginaState();
  }
}

class _CrearPedidoPaginaState extends State<CrearPedidoPagina> {
  final CrearPedidoVm vm = CrearPedidoVm();
  final TextEditingController controlador = TextEditingController();
  
  // Variable para controlar cuándo mostrar el error rojo en el input
  bool _intentoGuardar = false;

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

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

    if (!mounted) return;

    if (resultado != null) {
      setState(() {
        vm.actualizarItems(resultado as List<ItemPedido>);
      });
      
      // Feedback visual (Snackbar) al volver de seleccionar productos
      if ((resultado as List).isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Se han actualizado ${resultado.length} productos"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> verResumen() async {
    // Activamos la validación visual
    setState(() {
      _intentoGuardar = true;
    });

    if (!vm.puedeGuardar) {
      mostrarErrorValidacion();
      return;
    }

    await Navigator.pushNamed(
      context,
      '/resumen',
      arguments: vm.construirPedido(),
    );
  }

  void guardar() {
    setState(() {
      _intentoGuardar = true;
    });

    if (!vm.puedeGuardar) {
      mostrarErrorValidacion();
      return;
    }

    // Feedback de éxito antes de salir
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Pedido guardado correctamente"),
        backgroundColor: Colors.green, // Color verde para éxito
      ),
    );

    Navigator.pop(context, vm.construirPedido());
  }

  void mostrarErrorValidacion() {
    String mensaje = "";
    if (!vm.mesaEsOk) {
      mensaje = "Falta el nombre de la mesa. ";
    }
    if (!vm.hayProductos) {
      mensaje += "Debes añadir al menos un producto.";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.redAccent, // Color rojo para error
      ),
    );
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
              // VALIDACIÓN VISUAL: Muestra errorText si se intentó guardar y está vacío
              decoration: InputDecoration(
                hintText: "Escribe el nombre de la mesa",
                labelText: "Mesa",
                border: const OutlineInputBorder(),
                helperText: "Ej: Mesa 1, Barra, Terraza...", // Ayuda contextual
                errorText: _intentoGuardar && !vm.mesaEsOk 
                    ? "El nombre de la mesa es obligatorio" 
                    : null,
              ),
              onChanged: (valor) {
                setState(() {
                  vm.establecerMesa(valor);
                });
              },
            ),
          ),

          // Envolvemos botones en Tooltip para accesibilidad
          Tooltip(
            message: "Ir a la carta para seleccionar productos",
            child: ElevatedButton.icon(
              onPressed: () {
                irASeleccionar();
              },
              icon: const Icon(Icons.restaurant_menu),
              label: const Text("Añadir productos"),
            ),
          ),

          const SizedBox(height: 10),

          Tooltip(
            message: "Ver detalle antes de guardar",
            child: ElevatedButton.icon(
              onPressed: () {
                verResumen();
              },
              icon: const Icon(Icons.receipt_long),
              label: const Text("Ver resumen"),
            ),
          ),

          Expanded(
            child: Builder(
              builder: (context) {
                if (vm.itemsSeleccionados.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.fastfood_outlined, size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("La lista está vacía", style: TextStyle(color: Colors.grey)),
                        Text("Añade productos para comenzar", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: vm.itemsSeleccionados.length,
                    itemBuilder: (context, i) {
                      final item = vm.itemsSeleccionados[i];
                      return ListTile(
                        leading: CircleAvatar(child: Text("${item.cantidad}")),
                        title: Text(item.producto.nombre),
                        subtitle: Text("Subtotal: ${item.subtotal.toStringAsFixed(2)} €"),
                        trailing: IconButton(
                           icon: const Icon(Icons.delete, color: Colors.red),
                           tooltip: "Eliminar línea",
                           onPressed: () {
                             // Pequeña lógica para eliminar desde aquí si quisieras ampliar,
                             // pero por ahora solo es visualización.
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text("Edita los productos en 'Añadir productos'"))
                             );
                           },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total estimado:", style: TextStyle(fontSize: 16)),
                Text(
                  "${vm.totalPrecio.toStringAsFixed(2)} €",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      cancelar();
                    },
                    child: const Text("Cancelar"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Tooltip(
                    message: "Finalizar y guardar el pedido",
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        guardar();
                      },
                      child: const Text("Guardar pedido"),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}