import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/home_pages.dart';
import 'package:provider/provider.dart';

import '../preferences/pref_usuarios.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class PalabraPage extends StatefulWidget {
  const PalabraPage({Key? key});

  static const String routename = 'palabra_page';

  @override
  State<PalabraPage> createState() => _PalabraPageState();
}

class _PalabraPageState extends State<PalabraPage> {
  final prefs = PreferenciasUsuario();
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = Placeholder();
        break;
      case 4:
        page = Placeholder();
        Navigator.pushNamed(context, HomePage.routename);
        prefs.ultimaPagina = HomePage.routename;
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return ChangeNotifierProvider(
          create: (context) => MyAppState(),
          child: Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: const Icon(Icons.home),
                        label: const Text('Casa'),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.favorite),
                        label: const Text('Favoritos'),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.person),
                        label: const Text('Perfil'),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.settings),
                        label: const Text('Configuracion'),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text('Salir'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: page,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;

    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No hay favoritos'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Tienes ${appState.favorites.length} favoritos'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          )
      ],
      // child: Text('FAVORITES'),
    );
  }
}
