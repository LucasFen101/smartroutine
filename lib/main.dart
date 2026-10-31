import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SmartRoutineApp());
}

class SmartRoutineApp extends StatelessWidget {
  const SmartRoutineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartRoutine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class Task {
  String title;
  bool done;
  DateTime createdAt;

  Task({required this.title, this.done = false, DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'title': title,
    'done': done,
    'createdAt': createdAt.toIso8601String(),
  };

  static Task fromJson(Map<String, dynamic> json) => Task(
    title: json['title'] ?? '',
    done: json['done'] ?? false,
    createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks = [];
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('tasks') ?? '[]';
    List<dynamic> list;
    try {
      list = (jsonDecode(raw) as List).cast<dynamic>();
    } on FormatException {
      list = [];
    } on TypeError {
      list = [];
    }

    if (!mounted) return;
    setState(() {
      _tasks
        ..clear()
        ..addAll(list.map((e) => Task.fromJson(e as Map<String, dynamic>)));
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_tasks.map((t) => t.toJson()).toList());
    await prefs.setString('tasks', raw);
  }

  Future<void> _addTask(String title) async {
    final t = title.trim();
    if (t.isEmpty) return;
    setState(() => _tasks.add(Task(title: t)));
    await _saveTasks();
  }

  Future<void> _toggleTask(int index) async {
    setState(() => _tasks[index].done = !_tasks[index].done);
    await _saveTasks();
  }

  Future<void> _deleteTask(int index) async {
    setState(() => _tasks.removeAt(index));
    await _saveTasks();
  }

  int get _doneCount => _tasks.where((t) => t.done).length;
  int get _totalCount => _tasks.length;

  double get _percent {
    if (_totalCount == 0) return 0;
    return (_doneCount / _totalCount) * 100.0;
  }

  String _recommendation() {
    if (_totalCount == 0) {
      return 'Crie de 3 a 5 tarefas pequenas para começar. Rotina boa começa simples.';
    }

    if (_percent < 40) {
      return 'Você concluiu pouco hoje. Tente reduzir tarefas, dividir tarefas grandes e escolher só 3 prioridades.';
    }

    if (_percent >= 40 && _percent < 80) {
      return 'Bom ritmo. Para melhorar, defina um horário fixo e faça primeiro a tarefa mais importante do dia.';
    }

    return 'Excelente! Mantenha o padrão e lembre de incluir pausas curtas para não ficar exausto.';
  }

  Future<void> _showAddTaskDialog() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Nova tarefa'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Ex: Estudar 30 min'),
            autofocus: true,
            onSubmitted: (_) async {
              await _addTask(controller.text);
              if (ctx.mounted) Navigator.pop(ctx);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                await _addTask(controller.text);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _TasksPage(
        tasks: _tasks,
        onAdd: _showAddTaskDialog,
        onToggle: _toggleTask,
        onDelete: _deleteTask,
      ),
      _StatsPage(total: _totalCount, done: _doneCount, percent: _percent),
      _SmartPage(text: _recommendation()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('SmartRoutine')),
      body: pages[_tabIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.checklist), label: 'Tarefas'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Stats'),
          NavigationDestination(icon: Icon(Icons.lightbulb), label: 'Smart'),
        ],
      ),
    );
  }
}

class _TasksPage extends StatelessWidget {
  final List<Task> tasks;
  final VoidCallback onAdd;
  final Future<void> Function(int index) onToggle;
  final Future<void> Function(int index) onDelete;

  const _TasksPage({
    required this.tasks,
    required this.onAdd,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (tasks.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Nenhuma tarefa ainda.\nToque no + para adicionar.',
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: tasks.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final t = tasks[index];
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: t.done,
                    onChanged: (_) => onToggle(index),
                  ),
                  title: Text(
                    t.title,
                    style: TextStyle(
                      decoration: t.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(
                    'Criada em: ${t.createdAt.day.toString().padLeft(2, '0')}/'
                    '${t.createdAt.month.toString().padLeft(2, '0')}/'
                    '${t.createdAt.year}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDelete(index),
                  ),
                ),
              );
            },
          ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: onAdd,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class _StatsPage extends StatelessWidget {
  final int total;
  final int done;
  final double percent;

  const _StatsPage({
    required this.total,
    required this.done,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Total de tarefas: $total',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Concluídas: $done',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Percentual: ${percent.toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                total == 0
                    ? 'Crie tarefas para gerar estatísticas.'
                    : 'Meta simples: tente ficar acima de 70% na maioria dos dias.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmartPage extends StatelessWidget {
  final String text;
  const _SmartPage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recomendação inteligente',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(text, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              const Text(
                'Como funciona:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'O app usa regras simples baseadas no seu percentual de tarefas concluídas para sugerir melhorias na rotina.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
