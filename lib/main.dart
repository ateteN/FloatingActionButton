import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOpen = false;

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _close() {
    setState(() {
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 8,
            itemBuilder: (_, i) => ListTile(
              leading: const Icon(Icons.note),
              title: Text('Note ${i + 1}'),
            ),
          ),

          if (_isOpen)
            GestureDetector(
              onTap: _close,
              child: AnimatedOpacity(
                opacity: _isOpen ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_isOpen) ...[
            _buildAction(Icons.edit, "New Note", Colors.orange),
            _buildAction(Icons.camera_alt, "Camera", Colors.green),
            _buildAction(Icons.share, "Share", Colors.pinkAccent),
            _buildAction(Icons.mail, "Gmail", Colors.pinkAccent),

          ],
          
          FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: Colors.lightBlue,
            child: Icon(_isOpen ? Icons.close : Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 4)
              ],
            ),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(width: 10),

          FloatingActionButton.small(
            heroTag: label,
            backgroundColor: color,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$label clicked')),
              );
              _close();
            },
            child: Icon(icon, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
