import 'package:flutter/material.dart';
import '../viewmodels/inicio_vm.dart';
import '../models/pedido.dart';
import 'crear_pedido_pagina.dart';

class InicioPagina extends StatefulWidget {
  const InicioPagina({super.key});

  @override
  State<InicioPagina> createState() => _InicioPaginaState();
}

class _InicioPaginaState extends State<InicioPagina> {
  final InicioVm vm = InicioVm();

  Future<void> nuevoPedido() async {
    final pedido = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const CrearPedidoPagina();
        },
      ),
    );

    if (!mounted) {
      return;
    }

    if (pedido != null && pedido is Pedido) {
      setState(() {
        vm.agregarPedido(pedido);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget contenido;

    if (vm.pedidos.isEmpty) {
      contenido = const Center(
        child: Text("No hay pedidos todavía D:"),
      );
    } else {
      contenido = ListView.builder(
        itemCount: vm.pedidos.length,
        itemBuilder: (context, index) {
          final ped = vm.pedidos[index];
          return ListTile(
            title: Text(ped.mesa),
            subtitle: Text(
              "Productos: ${ped.totalDeProductos}  -  Total: ${ped.totalDePrecio.toStringAsFixed(2)} €",
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de pedidos"),
      ),
      body: contenido,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nuevoPedido();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
