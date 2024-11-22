import 'package:flutter/material.dart';
import '../cart/finish_cart.dart';
import 'detail.dart';
import 'client.dart';
import '../home/search_box.dart';

class SaleView extends StatefulWidget {
  final String _title;
  const SaleView(this._title, {super.key});
  @override
  State<StatefulWidget> createState() => _SaleView();
}

class _SaleView extends State<SaleView> {
  List<Sale> filteredSales = sales;
  String currentFilter = 'fecha';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          searchBox(context, _filterSales, _showFilterOptions),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSales.length,
              itemBuilder: (context, index) {
                final cliente = clients.firstWhere(
                  (cli) => cli.id == filteredSales[index].idCliente,
                  orElse: () => Client(id: 0, name: 'Desconocido', surname: ''),
                );
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${cliente.name} ${cliente.surname}"),
                      Text(
                        "${filteredSales[index].fecha.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink),
                      ),
                    ],
                  ),
                  subtitle: Text(
                      "Total: \$${filteredSales[index].total.toStringAsFixed(2)}"),
                  leading: CircleAvatar(
                    child: Text(cliente.name.substring(0, 1)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SaleDetailView(filteredSales[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClientView("Lista de Clientes"),
              ),
            );
          },
          tooltip: "Ver Clientes",
          child: const Icon(Icons.person),
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Filtrar por fecha'),
                onTap: () {
                  setState(() {
                    currentFilter = 'fecha';
                    filteredSales = sales;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Filtrar por nombre del cliente'),
                onTap: () {
                  setState(() {
                    currentFilter = 'name';
                    filteredSales = sales;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Filtrar por apellido del cliente'),
                onTap: () {
                  setState(() {
                    currentFilter = 'surname';
                    filteredSales = sales;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Filtrar por cédula del cliente'),
                onTap: () {
                  setState(() {
                    currentFilter = 'cedula';
                    filteredSales = sales;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.local_shipping),
                title: Text('Filtrar por Delivery'),
                onTap: () {
                  setState(() {
                    currentFilter = 'delivery';
                    filteredSales = sales
                        .where((sale) => sale.operation != 'pickup')
                        .toList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.store),
                title: Text('Filtrar por Pickup'),
                onTap: () {
                  setState(() {
                    currentFilter = 'pickup';
                    filteredSales = sales
                        .where((sale) => sale.operation == 'pickup')
                        .toList();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterSales(String query) {
    setState(() {
      if (currentFilter == 'fecha') {
        filteredSales = sales
            .where((sale) => sale.fecha.toString().contains(query))
            .toList();
      } else if (currentFilter == 'name') {
        filteredSales = sales.where((sale) {
          final cliente = clients.firstWhere((cli) => cli.id == sale.idCliente,
              orElse: () => Client(id: 0, name: '', surname: ''));
          return cliente.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else if (currentFilter == 'surname') {
        filteredSales = sales.where((sale) {
          final cliente = clients.firstWhere((cli) => cli.id == sale.idCliente,
              orElse: () => Client(id: 0, name: '', surname: ''));
          return cliente.surname.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else if (currentFilter == 'cedula') {
        filteredSales = sales.where((sale) {
          final cliente = clients.firstWhere((cli) => cli.id == sale.idCliente,
              orElse: () => Client(id: 0, name: '', surname: ''));
          return cliente.id.toString().contains(query);
        }).toList();
      }
    });
  }
}
