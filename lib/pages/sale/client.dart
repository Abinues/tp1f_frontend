import 'package:flutter/material.dart';
import '../cart/finish_cart.dart';

class ClientView extends StatelessWidget {
  final String title;
  const ClientView(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return ListTile(
            title: Text("${client.name} ${client.surname}"),
            subtitle: Text("CI: ${client.id}"),
            leading: CircleAvatar(
              child: Text(client.name.substring(0, 1)),
            ),
          );
        },
      ),
    );
  }
}
