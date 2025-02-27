import 'dart:convert';

import 'package:kidsdev_teste/db/api/api.dart';
import 'package:kidsdev_teste/db/api/funcao.dart';
import 'package:kidsdev_teste/db/api/if_else.dart';
import 'package:kidsdev_teste/db/api/laco.dart';
import 'package:kidsdev_teste/db/api/lista.dart';
import 'package:kidsdev_teste/db/api/operadores.dart';
import 'package:kidsdev_teste/db/api/variaveis.dart';

import 'package:kidsdev_teste/modules/quiz/quiz_page.dart';
import 'package:kidsdev_teste/shared/models/user_model.dart';
import 'package:kidsdev_teste/shared/themes/app_colors.dart';
import 'package:kidsdev_teste/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:kidsdev_teste/shared/desc.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var funcao = List<Funcao>.empty();
  var ifElse = List<IfElse>.empty();
  var laco = List<Laco>.empty();
  var list = List<Lista>.empty();
  var operadores = List<Operadores>.empty();
  var variaveis = List<Variaveis>.empty();

  _getFuncao() {
    API.getFuncao().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        funcao = lista.map((model) => Funcao.fromJson(model)).toList();
      });
    });
  }

  _getIfElse() {
    API.getFuncao().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        ifElse = lista.map((model) => IfElse.fromJson(model)).toList();
      });
    });
  }

  _getLaco() {
    API.getFuncao().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        laco = lista.map((model) => Laco.fromJson(model)).toList();
      });
    });
  }

  _getLista() {
    API.getFuncao().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        list = lista.map((model) => Lista.fromJson(model)).toList();
      });
    });
  }

  _getOperadores() {
    API.getFuncao().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        operadores = lista.map((model) => Operadores.fromJson(model)).toList();
      });
    });
  }

  _getVariaveis() {
    API.getFuncao().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        variaveis = lista.map((model) => Variaveis.fromJson(model)).toList();
      });
    });
  }

  _BuildListViewState() {
    _getFuncao();
    _getIfElse();
    _getLaco();
    _getLista();
    _getOperadores();
    _getVariaveis();
  }

  List<String> images = [
    "assets/images/variaveis.png",
    "assets/images/operadores.png",
    "assets/images/if.png",
    "assets/images/laco_repeticao.png",
    "assets/images/lista.png",
    "assets/images/funcao.png",
  ];

  var des = Description.des;
  var des1 = Description.des1;
  var des2 = Description.des2;
  var des3 = Description.des3;
  var des4 = Description.des4;
  var des5 = Description.des5;

  Widget customcard(String langname, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 10.0,
      ),
      child: InkWell(
        onTap: () {
          _modal(context, langname, des);
        },
        child: Material(
          color: AppColors.primary,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(100.0),
                  child: SizedBox(
                    height: 90.0,
                    width: 90.0,
                    child: ClipOval(
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          image,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    langname,
                    style: AppTextStyles.body20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: AppColors.primary,
          title: ListTile(
            title: Text.rich(
              TextSpan(text: "Olá, ", style: AppTextStyles.title, children: [
                TextSpan(text: widget.user.name, style: AppTextStyles.titleBold)
              ]),
              textAlign: TextAlign.start,
            ),
            trailing: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: NetworkImage(widget.user.photoURL!))),
            ),
          ),
          actions: [
            PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.logout, color: AppColors.black),
                      const SizedBox(width: 8),
                      const Text('Sair'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
              ],
            ),
          ],
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(5),
        crossAxisCount: 2,
        children: <Widget>[
          customcard("Variaveis", images[0]),
          customcard("Operadores", images[1]),
          customcard("If/else", images[2]),
          customcard("laço", images[3]),
          customcard("Lista", images[4]),
          customcard("Função", images[5]),
        ],
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print('clicou');
        Navigator.pushReplacementNamed(context, "/login");
        break;
    }
  }

  void _modal(context, langname, des) {
    var assettoload;
    var _url;

    if (langname == "Variaveis") {
      assettoload = des;
      _url =
          "https://vaiprogramar.com/o-que-sao-variaveis-em-programacao-passo-a-passo-com-exemplos/";
    } else if (langname == "Operadores") {
      assettoload = des1;
      _url =
          "https://autociencia.blogspot.com/2016/08/logica-de-programacao-operadores-aritmeticos.html";
    } else if (langname == "If/else") {
      assettoload = des2;
      _url =
          "https://pt.khanacademy.org/computing/computer-programming/programming/logic-if-statements/a/review-logic-and-if-statements";
    } else if (langname == "laço") {
      assettoload = des3;
      _url =
          "http://www.bosontreinamentos.com.br/logica-de-programacao/13-logica-de-programacao-estruturas-de-repeticao-loop-enquanto/";
    } else if (langname == "Lista") {
      assettoload = des4;
      _url =
          "http://www.bosontreinamentos.com.br/logica-de-programacao/17-logica-de-programacao-vetores-definicao-e-declaracao/";
    } else {
      assettoload = des5;
      _url =
          "https://dicasdeprogramacao.com.br/o-que-sao-funcoes-e-procedimentos/";
    }

    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(28.0),
          child: SizedBox(
            height: 350,
            child: Center(
              child: ListView(
                children: [
                  Text(assettoload),
                  Expanded(
                    child: Container(
                      width: 100,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await canLaunch(_url)
                                ? await launch(_url)
                                : throw 'Could not launch $_url';
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.red, //background
                            onPrimary: AppColors.white, //font
                          ),
                          child: const Text('Aprender Mais')),
                      ElevatedButton(
                        child: const Text('Começar'),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => GetJson(themeName: langname),
                          ));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
