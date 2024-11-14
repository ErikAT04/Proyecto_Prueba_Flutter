import 'package:flutter/material.dart';
import 'package:proyectoapp/MainApp.dart';
import 'package:proyectoapp/Tarjetas.dart';

class NavInferior extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavInferiorState();
  }
}

class NavInferiorState extends State<NavInferior> {
  List<BottomNavigationBarItem> listaBotones = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Principal"),
    BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "Perfil")
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Página Principal"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: listaBotones,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
        ),
        body: (index == 0) ? HomePageScreen() : SettingsScreen());
  }
}

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          NetworkImage im = NetworkImage(
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");
          String txt = "Texto de Ejemplo";
          return GestureDetector(
            child: Card(
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: im),
                  Text(txt),
                ],
              ),
            ),
            onTap: () {
              List list = [txt, im];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfoTarjeta(),
                      settings: RouteSettings(arguments: list)));
            },
          );
        });
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsScreen> {
  bool valor = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Cambiar fondo"),
            Switch(
                value: valor,
                onChanged: (value) {
                  setState(() {
                    valor = !valor;
                    ThemeData data =
                        (valor) ? ThemeData.dark() : ThemeData.light();
                    context
                        .findAncestorStateOfType<MainState>()!
                        .updateTheme(data);
                  });
                })
          ],
        ),
        SizedBox(height: 50),
        Text("Aplicación desarrollada por Erik"),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/pestanas");
            },
            child: Text("Acceder al Formulario"))
      ],
    );
  }
}
