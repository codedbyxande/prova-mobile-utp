import 'package:flutter/material.dart';

void main() => runApp(const PerfilArtistaApp());

class PerfilArtistaApp extends StatelessWidget {
  const PerfilArtistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil do Artista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.black, // Cor padrão para todos os ícones
          size: 24, // Tamanho padrão
        ),
      ),
      home: const PerfilArtistaPage(),
    );
  }
}

class PerfilArtistaPage extends StatefulWidget {
  const PerfilArtistaPage({super.key});

  @override
  State<PerfilArtistaPage> createState() => _PerfilArtistaPageState();
}

class _PerfilArtistaPageState extends State<PerfilArtistaPage> {
  bool curtido = false;
  bool seguindo = false;

  void _toggleCurtir() {
    setState(() => curtido = !curtido);
  }

  void _toggleSeguir() {
    setState(() => seguindo = !seguindo);
  }

  void _ouvirAgora() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🎵 Tocando agora...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const spacing = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Artista'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.star,
                size: 48,
                color: Colors.blue,
              ),
            ),
            const Center(
              child: Text('Hum'),
            ),
            spacing,
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: const AssetImage('assets/imagens/artista.png'),
              ),
            ),
            spacing,
            Center(
              child: Text(
                'Nome do Artista',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                'Estilo Musical • Pop/Rock',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Musicas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.album,
                        size: 32,
                        color: Colors.black,
                      ),
                      title: Text('MusicaUm'),
                      subtitle: Text('2020'),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.album,
                        size: 32,
                        color: Colors.black,
                      ),
                      title: Text('MusicaDois'),
                      subtitle: Text('2016'),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.album,
                        size: 32,
                        color: Colors.black,
                      ),
                      title: Text('MusicaTres'),
                      subtitle: Text('2015'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _toggleCurtir,
              icon: Icon(
                curtido ? Icons.favorite : Icons.favorite_border,
                color: curtido ? Colors.red : Colors.black,
              ),
              label: Text(curtido ? 'Curtido' : 'Curtir'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _toggleSeguir,
              icon: Icon(
                seguindo ? Icons.check : Icons.person_add_alt_1,
                color: seguindo ? Colors.green : Colors.black,
              ),
              label: Text(seguindo ? 'Seguindo' : 'Seguir'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _ouvirAgora,
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.black,
              ),
              label: const Text('Ouvir'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
