import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavPestanas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatePestanas();
  }
}

class StatePestanas extends State<NavPestanas> {
  List<Tab> tabs = [
    Tab(text: "Formulario 1"),
    Tab(
      text: "Formulario 2",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Formularios"),
            bottom: TabBar(tabs: tabs),
          ),
          body: TabBarView(children: [
            Formulario1(),
            Formulario2(),
          ]),
        ));
  }
}

class Formulario2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateForm2();
  }
}

class StateForm2 extends State<Formulario2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerMail = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  String respuesta = "Hombre";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controllerMail,
                  decoration: InputDecoration(
                      labelText: "Escribe un correo electrónico"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Introduce un valor";
                    } else if (RegExp(r'[a-zA-Z0-9]+@[a-zA-Z]+\.[a-z]{3}')
                        .hasMatch(value)) {
                      return null;
                    } else {
                      return "No cumple los criterios de validación";
                    }
                  },
                ),
                TextFormField(
                  controller: controllerName,
                  decoration: InputDecoration(labelText: "Escribe tu nombre"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Introduce un valor";
                    } else if (RegExp(r'^[A-Z][a-z]+').hasMatch(value)) {
                      return null;
                    } else {
                      return "Ese no es un nombre";
                    }
                  },
                ),
                DropdownButtonFormField<String>(
                  items: [
                    DropdownMenuItem(child: Text("Hombre"), value: "Hombre"),
                    DropdownMenuItem(child: Text("Mujer"), value: "Mujer"),
                    DropdownMenuItem(child: Text("Otro"), value: "Otro")
                  ],
                  onChanged: (value) {
                    respuesta = value.toString();
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Debes elegir un valor";
                    } else {
                      return null;
                    }
                  },
                )
              ],
            )),
        FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Map<String, String> data = {
                "Formulario hecho": "2",
                "Nombre": controllerName.text,
                "Correo": controllerMail.text,
                "Género": respuesta
              };
              Navigator.pushNamed(context, "/resultado", arguments: data);
            }
          },
          child: Text("Enviar"),
        )
      ],
    );
  }
}

class Formulario1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateForm1();
  }
}

class StateForm1 extends State<Formulario1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerMail = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controllerMail,
                  decoration: InputDecoration(
                      labelText: "Escribe un correo electrónico"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Introduce un valor";
                    } else if (RegExp(r'[a-zA-Z0-9]+@[a-zA-Z]+\.[a-z]{3}')
                        .hasMatch(value)) {
                      return null;
                    } else {
                      return "No cumple los criterios de validación";
                    }
                  },
                ),
                TextFormField(
                  controller: controllerName,
                  decoration: InputDecoration(labelText: "Escribe tu nombre"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Introduce un valor";
                    } else if (RegExp(r'^[A-Z][a-z]+').hasMatch(value)) {
                      return null;
                    } else {
                      return "Ese no es un nombre";
                    }
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Escribe tu contraseña"),
                  obscureText: true,
                  controller: controllerPass,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return "Rellena la contraseña correctamente";
                    } else if (RegExp(r'[\w\n]*').hasMatch(value)) {
                      return null;
                    } else {
                      return "Formato de Contraseña inválido";
                    }
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Escribe tu contraseña"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Escribe en el campo";
                    } else if (value != controllerPass.text) {
                      return "Las contraseñas no coinciden";
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            )),
        FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Map<String, String> data = {
                "Formulario hecho": "1",
                "Nombre": controllerName.text,
                "Correo": controllerMail.text,
                "Contraseña": controllerPass.text
              };
              Navigator.pushNamed(context, "/resultado", arguments: data);
            }
          },
          child: Text("Enviar"),
        )
      ],
    );
  }
}

class RespuestaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, String> map =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    List<String> claves = [];
    List<String> valores = [];
    for (String clave in map.keys) {
      claves.add(clave);
      valores.add(map[clave]!);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado del formulario"),
      ),
      body: ListView.builder(
          itemCount: map.length,
          itemBuilder: (context, index) {
            return Text("${claves[index]} : ${valores[index]}");
          }),
    );
  }
}
