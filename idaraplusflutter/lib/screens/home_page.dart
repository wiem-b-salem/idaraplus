import 'package:flutter/material.dart';
import 'demarches_page.dart';
import 'suivi_page.dart';
import 'chat_ia_page.dart';
import 'profil_page.dart';
import 'poste_page.dart';
import 'municipalite_page.dart';
import 'poste_police_page.dart';
import 'recette_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 2; // Accueil is at index 2 (center)
  late PageController _pageController;

  // Models for administrations
  final List<Map<String, dynamic>> administrations = [
    {
      'name': 'Poste',
      'icon': Icons.local_post_office,
      'color': Color(0xFF2196F3),
    },
    {
      'name': 'Municipalité',
      'icon': Icons.apartment,
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'Poste de Police',
      'icon': Icons.security,
      'color': Color(0xFFFF9800),
    },
    {
      'name': 'Recette des Finances',
      'icon': Icons.account_balance,
      'color': Color(0xFF9C27B0),
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildDemarchesView(),
          _buildSuiviView(),
          _buildAccueilView(),
          _buildChatIAView(),
          _buildProfilView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF1976D2),
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Démarches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Suivi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat IA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildDemarchesView() {
    return const DemarchesPage();
  }

  Widget _buildSuiviView() {
    return const SuiviPage();
  }

  Widget _buildAccueilView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        elevation: 0,
        title: const Text(
          'Accueil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Choisir votre administration',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 40),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: administrations.length,
                      itemBuilder: (context, index) {
                        return _buildAdministrationCard(
                          administrations[index],
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatIAView() {
    return const ChatIAPage();
  }

  Widget _buildProfilView() {
    return const ProfilPage();
  }

  Widget _buildAdministrationCard(Map<String, dynamic> admin) {
    return GestureDetector(
      onTap: () {
        _navigateToAdministration(admin['name']);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: () {
              _navigateToAdministration(admin['name']);
            },
            borderRadius: BorderRadius.circular(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: admin['color'],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    admin['icon'],
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  admin['name'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToAdministration(String adminName) {
    Widget page;
    
    switch (adminName) {
      case 'Poste':
        page = const PostePage();
        break;
      case 'Municipalité':
        page = const MunicipalitePage();
        break;
      case 'Poste de Police':
        page = const PostePolicePage();
        break;
      case 'Recette des Finances':
        page = const RecettePage();
        break;
      default:
        return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}