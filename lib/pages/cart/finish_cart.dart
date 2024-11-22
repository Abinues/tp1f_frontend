import 'package:flutter/material.dart';
import '../home/popular_products.dart';

import '../text_box.dart';

class FinishCart extends StatefulWidget {
  final double total;

  FinishCart({required this.total});

  @override
  State<StatefulWidget> createState() {
    return _FinishCart();
  }
}

List<Client> clients = [
  Client(id: 5869534, name: 'Abigail', surname: 'Fernandez'),
  Client(id: 4699787, name: 'Carlos', surname: 'Piedrabuena'),
  Client(id: 5411448, name: 'Alejandro', surname: 'Baez'),
];

List<Sale> sales = [
  // Venta 1 para Abigail Fernandez
  Sale(
      fecha: DateTime(2024, 10, 1, 10, 30),
      idCliente: 5869534,
      detalle: [
        ProductsCounter(idProduct: 0, count: 3), // Manzana (3 unidades)
        ProductsCounter(idProduct: 4, count: 2), // Tomate (2 unidades)
      ],
      total: 3 * 1.2 + 2 * 0.9,
      operation: "Aviadores del Chaco 202, Asunción, Paraguay"),

  // Venta 2 para Carlos Piedrabuena
  Sale(
      fecha: DateTime(2024, 10, 3, 14, 45),
      idCliente: 4699787,
      detalle: [
        ProductsCounter(idProduct: 9, count: 1), // Queso (1 unidad)
        ProductsCounter(idProduct: 12, count: 1), // Carne de Res (1 unidad)
        ProductsCounter(idProduct: 18, count: 3), // Refresco (3 unidades)
      ],
      total: 1 * 2.5 + 1 * 7.5 + 3 * 1.0,
      operation: "pickup"),

  // Venta 3 para Alejandro Baez
  Sale(
      fecha: DateTime(2024, 10, 5, 9, 20),
      idCliente: 5411448,
      detalle: [
        ProductsCounter(idProduct: 5, count: 4), // Zanahoria (4 unidades)
        ProductsCounter(idProduct: 11, count: 1), // Pollo (1 unidad)
      ],
      total: 4 * 0.7 + 1 * 5.0,
      operation: "Grabadores del Cabichuí 2716, Asunción, Paraguay"),

  // Venta 4 para Abigail Fernandez
  Sale(
      fecha: DateTime(2024, 10, 6, 11, 10),
      idCliente: 5869534,
      detalle: [
        ProductsCounter(idProduct: 14, count: 1), // Croissant (1 unidad)
        ProductsCounter(idProduct: 20, count: 2), // Chocolate (2 unidades)
      ],
      total: 1 * 1.2 + 2 * 1.7,
      operation: "pickup"),

  // Venta 5 para Carlos Piedrabuena
  Sale(
      fecha: DateTime(2024, 10, 1, 10, 30),
      idCliente: 4699787,
      detalle: [
        ProductsCounter(idProduct: 21, count: 2), // Avena (2 unidades)
        ProductsCounter(idProduct: 23, count: 1), // Pimienta (1 unidad)
      ],
      total: 2 * 2.0 + 1 * 0.7,
      operation: "pickup"),
];

class _FinishCart extends State<FinishCart> {
  late TextEditingController cedulaController;
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController addressController;
  bool isFormValid = false;
  String operation = "pickup";

  @override
  void initState() {
    super.initState();
    cedulaController = TextEditingController();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    addressController = TextEditingController();

    cedulaController.addListener(validateForm);
    nameController.addListener(validateForm);
    surnameController.addListener(validateForm);
    addressController.addListener(validateForm);
  }

  void validateForm() {
    setState(() {
      isFormValid = cedulaController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          surnameController.text.isNotEmpty &&
          int.tryParse(cedulaController.text) != null &&
          (operation == "pickup" || addressController.text.isNotEmpty);
    });
  }

  @override
  void dispose() {
    cedulaController.dispose();
    nameController.dispose();
    surnameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalizar Compra"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(cedulaController, "Cédula"),
            TextBox(nameController, "Nombre"),
            TextBox(surnameController, "Apellido"),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Método de entrega",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text("Pickup"),
                  leading: Radio<String>(
                    value: "pickup",
                    groupValue: operation,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        operation = value!;
                        addressController.clear();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text("Delivery"),
                  leading: Radio<String>(
                    value: "delivery",
                    groupValue: operation,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        operation = value!;
                      });
                    },
                  ),
                ),
                if (operation == "delivery")
                  TextBox(addressController, "Dirección de entrega"),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isFormValid
                  ? () {
                      int idClient = int.parse(cedulaController.text);
                      String name = nameController.text;
                      String surname = surnameController.text;
                      String operationValue = operation == "pickup"
                          ? "pickup"
                          : addressController.text;

                      finishCart(
                        idClient: idClient,
                        name: name,
                        surname: surname,
                        productCounters: productCounters,
                        total: widget.total,
                        operation: operationValue,
                      );

                      Navigator.pop(context, true);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary),
              child: Text("Finalizar Compra"),
            ),
          ],
        ),
      ),
    );
  }
}

class Client {
  int id;
  String name;
  String surname;

  Client({
    required this.id,
    required this.name,
    required this.surname,
  });
}

class Sale {
  static int _idCounter = 0;
  int id;
  DateTime fecha;
  int idCliente;
  List<ProductsCounter> detalle;
  double total;
  String operation;

  Sale({
    required this.fecha,
    required this.idCliente,
    required this.detalle,
    required this.total,
    required this.operation,
  }) : id = _idCounter++;
}

void finishCart({
  required int idClient,
  required String name,
  required String surname,
  required List<ProductsCounter> productCounters,
  required double total,
  required String operation,
}) {
  Client? existingClient = clients.firstWhere(
    (client) => client.id == idClient,
    orElse: () => Client(id: idClient, name: name, surname: surname),
  );

  if (!clients.contains(existingClient)) {
    clients.add(existingClient);
  }

  List<ProductsCounter> productCountersCopy = List.from(productCounters);

  Sale newSale = Sale(
    fecha: DateTime.now(),
    idCliente: idClient,
    detalle: productCountersCopy,
    total: total,
    operation: operation,
  );

  sales.add(newSale);
}
