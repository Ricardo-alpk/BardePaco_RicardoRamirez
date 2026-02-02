class Producto {
  final String id;
  final String nombre;
  final double precio;

  const Producto({
    required this.id,
    required this.nombre,
    required this.precio,
  });

  static const List<Producto> cartita = [
    Producto(id: '1', nombre: 'caña', precio: 1.20),
    Producto(id: '2', nombre: 'pincho de tortilla', precio: 1.60),
    Producto(id: '3', nombre: 'Coca-Cola', precio: 1.00),
    Producto(id: '4', nombre: 'lomo saltado', precio: 1.30),
    Producto(id: '5', nombre: 'Chicha Morada', precio: 1.70),
    Producto(id: '6', nombre: 'Ración Papas Fritas', precio: 2.00),
    Producto(id: '7', nombre: 'Hamburguesa', precio: 2.00),
    Producto(id: '8', nombre: 'Monstrito', precio: 2.30),
  ];
}
