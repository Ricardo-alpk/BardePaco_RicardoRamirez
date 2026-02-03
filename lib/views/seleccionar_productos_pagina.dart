import 'package:flutter/material.dart';
import '../viewmodels/seleccionar_productos.dart';
import '../models/item_pedido.dart';

/// Pantalla que muestra la lista de productos disponibles para añadir al pedido.
///
/// Permite incrementar o decrementar la cantidad de cada producto.
/// Recibe [itemsIniciales] si se está editando una selección previa.
class SeleccionarProductosPagina extends StatefulWidget {
  final List<ItemPedido> itemsIniciales;

  const SeleccionarProductosPagina({
    super.key,
    required this.itemsIniciales,
  });

  @override
  State<SeleccionarProductosPagina> createState() {
    return _SeleccionarProductosPaginaState();
  }
}

class _SeleccionarProductosPaginaState extends State<SeleccionarProductosPagina> {
  late SeleccionarProductosVM vm;

  @override
  void initState() {
    super.initState();
    vm = SeleccionarProductosVM();

    // Cargar productos ya seleccionados antes
    for (var item in widget.itemsIniciales) {
      vm.cantidades[item.producto] = item.cantidad;
    }
  }

  /// Retorna la lista de items seleccionados a la pantalla anterior.
  void confirmar() {
    Navigator.pop(context, vm.construirItems());
  }

  void cancelar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vm.carta.length,
              itemBuilder: (context, index) {
                final producto = vm.carta[index];
                final cantidad = vm.cantidadProducto(producto);

                return ListTile(
                  title: Text(producto.nombre),
                  subtitle: Text("${producto.precio} €"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            vm.disminuir(producto);
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text("$cantidad"),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            vm.aumentar(producto);
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 5),

          Text("Total: ${vm.total.toStringAsFixed(2)} €"),

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
                    confirmar();
                  },
                  child: const Text("Confirmar"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}