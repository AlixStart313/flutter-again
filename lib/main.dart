import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/model/computer_system.dart';
import 'package:prueba1/presentation/cubit/data_cubit.dart';
import 'package:prueba1/presentation/data_state.dart';
import 'package:prueba1/repostory/data_repository.dart';
import 'package:prueba1/model/component_types_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final DataRepository repository = DataRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataCubit>(
          create: (context) => DataCubit(repository: repository)..getData(),
        ),
      ],
      child: MaterialApp(
        title: 'recupera pre extra',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ComponentTypes();
        break;
      case 1:
        page = MyDropdownButtonExample();
        break;
      case 2:
        page = MyDataTableExample();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Computer systems'),
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
      );
    });
  }
}

/* class GeneratorPage extends StatelessWidget {
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
} */

/* class BigCard extends StatelessWidget {
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
        padding: const EdgeInsets.all(14.0),
        child: Text(
          pair.asLowerCase,
          style: style,
        ),
      ),
    );
  }
}
 */

/* class favoriteNames extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
     var appState = context.watch<MyAppState>();
     
     if (appState.favorites.isEmpty) {
       return Center(
        child: Text('Sin favoritos aun'),
       );
     }
    return 
      ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('You have this favorites'),
          ),
            for (var pair in appState.favorites)
              ListTile(
                leading: Icon(Icons.favorite),
                  title: Text(pair.toString().toLowerCase())
              ), 
        ],
      );
  }
}
 */
class MyDropdownButtonExample extends StatefulWidget {
  @override
  _MyDropdownButtonExampleState createState() =>
      _MyDropdownButtonExampleState();
}

class _MyDropdownButtonExampleState extends State<MyDropdownButtonExample> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    context.read<DataCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DropdownButton Example'),
      ),
      body: BlocBuilder<DataCubit, DataState>(builder: (context, state) {
        if (state is DataLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DataSuccess) {
          if (_selectedValue == null && state.types.isNotEmpty) {
            _selectedValue = state.types.first.name;
          }
          return DropdownButton<String>(
            value: _selectedValue,
            style: const TextStyle(color: Colors.deepPurple),
            items: state.types.map<DropdownMenuItem<String>>((type) {
              return DropdownMenuItem<String>(
                  value: type.name, child: Text(type.name.toString()));
            }).toList(),
            onChanged: (String? newVal) {
              print(newVal);
              setState(() {
                _selectedValue = newVal!;
              });
            },
          );
        } else if (state is DataError) {
          return Center(
            child: Text('Sin info ${state.message}'),
          );
        } else {
          return Center(child: Text('No data'));
        }
      }),
    );
  }
}

class MyDataTableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DataTable Example'),
        ),
        body: BlocBuilder<DataCubit, DataState>(builder: (context, state) {
          if (state is DataLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DataSuccess) {
            List<ComputerSystem> computerSystem =
                state.computers.cast<ComputerSystem>();
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("#")),
                    DataColumn(label: Text("Nombre")),
                    DataColumn(label: Text("Acciones"))
                  ],
                  rows: computerSystem.asMap().entries.map((entry) {
                    int index = entry.key;
                    var system = entry.value;
                    return DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(system.name)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.update),
                              onPressed: () {
                                // Acción de actualizar
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Acción de eliminar
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_red_eye_sharp),
                              onPressed: () {
                                showDialog(context: context, 
                                builder: (context){
                                  return DetailscomputerModal(computerSystem: system);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('NO hay equipos de computo regstrados'),
            );
          }
        }));
  }
}

class ComponentTypes extends StatelessWidget {
  const ComponentTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<DataCubit, DataState>(builder: (context, state) {
      if (state is DataSuccess) {
        final types = state.types;
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('your component_types'),
            ),
            ...types.map((item) => ListTile(
                  title: Text(item.name.toString()),
                ))
          ],
        );
      } else if (state is DataError) {
        return Center(
            child: Text(
                'Error al obtener los tipos de componentes ${state.message}'));
      } else {
        return Center(child: Text('Error al obtener los tipos de componentes'));
      }
    }));
  }
}

class DetailscomputerModal extends StatelessWidget {
  final ComputerSystem computerSystem;

  const DetailscomputerModal({required this.computerSystem, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Detalles'),
      content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  initialValue: computerSystem.name,
                  decoration:
                      const InputDecoration(labelText: 'Nombre del sistema'),
                  enabled: false),
                  TextFormField(
                    initialValue: computerSystem.components.toString(),
                    decoration:
                    const InputDecoration(labelText: 'Nombre del componete') ,
                    enabled: false,
                  )
            ],
            
          )),
      actions: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ))
      ],
    );
  }
}
