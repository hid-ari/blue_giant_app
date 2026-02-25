import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueAccent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final pages = const [
    PortadaScreen(),
    PersonajesScreen(),
    MomentosScreen(),
    AcercaScreen(),
    EnMiVidaScreen(),
    ContratameScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Portada"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: "Personajes"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Momentos"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Acerca"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_call), label: "En mi vida"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Contrátame"),
        ],
      ),
    );
  }
}

class PortadaScreen extends StatelessWidget {
  const PortadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blue Giant"), centerTitle: true),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(height: 500, autoPlay: true),
          items: [
            "assets/images/cover1.jpg",
            "assets/images/cover2.jpg",
            "assets/images/cover3.jpg",
          ].map((i) {
            return Image.asset(i, fit: BoxFit.cover);
          }).toList(),
        ),
      ),
    );
  }
}

class Personaje {
  final String nombre;
  final String imagen;
  final String descripcion;
  Personaje(this.nombre, this.imagen, this.descripcion);
}

class PersonajesScreen extends StatelessWidget {
  const PersonajesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personajes = [
      Personaje("Dai Miyamoto", "assets/images/dai.png",
          "Saxofonista apasionado decidido a ser el mejor."),
      Personaje("Yukinori Sawabe", "assets/images/yuki.png",
          "Pianista profesional con técnica impecable."),
      Personaje("Shunji Tamada", "assets/images/shunji.png",
          "Baterista que evoluciona con esfuerzo."),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Personajes"), centerTitle: true),
      body: ListView.builder(
        itemCount: personajes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Center(
              child: Text(
                personajes[index].nombre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PersonajeDetalle(personajes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PersonajeDetalle extends StatelessWidget {
  final Personaje personaje;
  const PersonajeDetalle(this.personaje, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(personaje.nombre), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(personaje.imagen, height: 250),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                personaje.descripcion,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Momento {
  final String titulo;
  final String imagen;
  final String video;
  final String descripcion;
  Momento(this.titulo, this.imagen, this.video, this.descripcion);
}

class MomentosScreen extends StatelessWidget {
  const MomentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final momentos = [
      Momento("Primer Concierto", "assets/images/momento1.png",
          "assets/videos/momento1.mp4", "Inicio oficial del grupo."),
      Momento("Audición Importante", "assets/images/momento2.png",
          "assets/videos/momento2.mp4", "Momento decisivo."),
      Momento("Improvisación Final", "assets/images/momento3.png",
          "assets/videos/momento3.mp4", "Clímax emocional."),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Momentos"), centerTitle: true),
      body: ListView.builder(
        itemCount: momentos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              children: [
                Image.asset(momentos[index].imagen, height: 150),
                const SizedBox(height: 10),
                Text(
                  momentos[index].titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MomentoDetalle(momentos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MomentoDetalle extends StatefulWidget {
  final Momento momento;
  const MomentoDetalle(this.momento, {super.key});

  @override
  State<MomentoDetalle> createState() => _MomentoDetalleState();
}

class _MomentoDetalleState extends State<MomentoDetalle> {
  late VideoPlayerController controller;
  bool mostrarVideo = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.momento.video)
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.momento.titulo), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!mostrarVideo) ...[
                Image.asset(widget.momento.imagen, height: 250),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.momento.descripcion,
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      mostrarVideo = true;
                    });
                  },
                  child: const Text("Ver Video"),
                ),
              ],
              if (mostrarVideo && controller.value.isInitialized) ...[
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.play(),
                  child: const Text("Reproducir"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Blue Giant es una película basada en el manga creado por Shinichi Ishizuka.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class EnMiVidaScreen extends StatefulWidget {
  const EnMiVidaScreen({super.key});
  @override
  State<EnMiVidaScreen> createState() => _EnMiVidaScreenState();
}

class _EnMiVidaScreenState extends State<EnMiVidaScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/videos/hideki_video.mp4")
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("En mi vida"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hideki 20241453"),
            const SizedBox(height: 20),
            if (controller.value.isInitialized)
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => controller.play(),
              child: const Text("Reproducir Video"),
            ),
          ],
        ),
      ),
    );
  }
}

class ContratameScreen extends StatelessWidget {
  const ContratameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/hideki.png"),
            ),
            SizedBox(height: 20),
            Text("Hideki"),
            Text("20241453"),
            Text("ariyamahideki1@gmail.com"),
            Text("829-410-1140"),
          ],
        ),
      ),
    );
  }
}
