import 'package:flutter/material.dart';

class InfoTarjeta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List list = ModalRoute.of(context)!.settings.arguments as List;
    String texto = list[0];
    NetworkImage imagen = list[1];
    return Scaffold(
      appBar: AppBar(
        title: Text("Información de la tarjeta:"),
      ),
      body: Column(
        children: [
          Row(
            children: [Text("Avatar:"), CircleAvatar(backgroundImage: imagen)],
          ),
          Row(
            children: [Text("Texto: $texto")],
          )
        ],
      ),
    );
  }
}
