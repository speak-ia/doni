import 'package:donidata/constante/category_item.dart';
import 'package:donidata/constante/enquete_card.dart';
import 'package:donidata/provider/userProvider.dart';
import 'package:donidata/screen/drawer/notification_page.dart';
import 'package:donidata/screen/custom_drawer.dart';
import 'package:donidata/screen/detailsEnquete.dart';
import 'package:donidata/screen/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedCategory = 0;
final List<Map<String, dynamic>> categories = [
    {'name': 'Tout', 'icon': Icons.widgets},
    {'name': 'Ongs', 'icon': Icons.volunteer_activism},
    {'name': 'Entreprises', 'icon': Icons.business},
    {'name': 'Gouvernements', 'icon': Icons.account_balance},
  ];

  // Sample data for top enquêtes
  final List<Map<String, String>> topEnquetes = [
    {
      'title': 'Orange',
      'description': 'Procédure d\'identification',
      'image': 'assets/images/top3.png',
    },
    {
      'title': 'Helen Keller Intl',
      'description': 'Procédure d\'identification',
      'image': 'assets/images/top2.png',
    },
    {
      'title': 'Gouvernement',
      'description': 'Procédure d\'identification',
      'image': 'assets/images/top1.png',
    },
  ];

  // Sample data for local enquêtes
  final List<Map<String, String>> localEnquetes = [
    {'title': 'Enquête santé', 'image': 'assets/images/a.png'},
    {'title': 'Éducation', 'image': 'assets/images/b.png'},
    {'title': 'Agriculture', 'image': 'assets/images/c.png'},
    {'title': 'Orange', 'image': 'assets/images/d.png'},
    {'title': 'UN', 'image': 'assets/images/e.png'},
    {'title': 'PSI', 'image': 'assets/images/f.png'},
    {'title': 'Save the Children', 'image': 'assets/images/a.png'},
    {'title': 'Care', 'image': 'assets/images/i.png'},
  ];



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        elevation: 0,
        toolbarHeight: 80,
        leading: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: CircleAvatar(
              backgroundImage: user?.photoUrl != null
                  ? NetworkImage(user!.photoUrl!)
                  : AssetImage('assets/images/logo.png',) as ImageProvider,
              radius: screenWidth * 0.05,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.fullname ?? 'Nom inconnu',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Enqueteur",
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: screenWidth * 0.07,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationSettingsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
              size: screenWidth * 0.07,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02,
              ),
              child: Center(
                child: Text(
                  'BIENVENUE',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Recherche',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Categories Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(categories.length, (index) {
                  return CategoryItem(
                    name: categories[index]['name'],
                    icon: categories[index]['icon'],
                    isSelected: selectedCategory == index,
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Top Enquêtes Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(
                'Top Enquêtes',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Horizontal list of Top Enquêtes
            SizedBox(
              height: screenHeight * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topEnquetes.length,
                itemBuilder: (context, index) {
                  return EnqueteCard(
                    title: topEnquetes[index]['title']!,
                    description: topEnquetes[index]['description']!,
                    image: topEnquetes[index]['image']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnqueteDetailPage(
                            enquete: topEnquetes[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(
                'Enquêtes disponibles dans votre localité',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Local Enquêtes Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Fixé à 4 icônes par ligne
                  crossAxisSpacing: screenWidth * 0.02,
                  mainAxisSpacing: screenHeight * 0.02,
                  childAspectRatio: 0.75,
                ),
                itemCount: localEnquetes.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Image circulaire de l'enquête
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          localEnquetes[index]['image']!,
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // Titre de l'enquête
                      Text(
                        localEnquetes[index]['title']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff0A1B34),
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
