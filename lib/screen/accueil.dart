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

  final List<Map<String, String>> topEnquetes = [
    {'title': 'Save the Children', 'description': 'Protection de l\'enfance', 'image': 'assets/images/top1.png'},
    {'title': 'UN', 'description': 'Programme d\'éducation', 'image': 'assets/images/top1.png'},
    {'title': 'PSI', 'description': 'Étude sur la santé publique', 'image': 'assets/images/top2.png'},
    {'title': 'Gouvernement', 'description': 'Procédure d\'identification', 'image': 'assets/images/top1.png'},
    {'title': 'Helen Keller Intl', 'description': 'Procédure d\'identification', 'image': 'assets/images/top2.png'},
    {'title': 'Orange', 'description': 'Procédure d\'identification', 'image': 'assets/images/top3.png'},
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
                  : AssetImage('assets/images/logo.png') as ImageProvider,
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: topEnquetes.length < 9 ? topEnquetes.length : 9,
                itemBuilder: (context, index) {
                  return EnqueteCard(
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

                    title: topEnquetes[index]['title']!,
                    description: topEnquetes[index]['description']!,
                    image: topEnquetes[index]['image']!,
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Voir plus"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: (topEnquetes.length > 9) ? 3 : 0,
                itemBuilder: (context, index) {
                  return EnqueteCard(
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

                    title: topEnquetes.length > index + 9 ? topEnquetes[index + 9]['title']! : '',
                    description: topEnquetes.length > index + 9 ? topEnquetes[index + 9]['description']! : '',
                    image: topEnquetes.length > index + 9 ? topEnquetes[index + 9]['image']! : '',
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
