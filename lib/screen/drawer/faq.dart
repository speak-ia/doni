import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comment Pouvons-Nous Vous Aider?',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barre de recherche
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.blueAccent),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),

            // Tabs pour "FAQ" et "Contact Us"
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.blueAccent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blueAccent,
              indicator: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30),
              ),
              tabs: const [
                Tab(text: "FAQ"),
                Tab(text: "Contact Us"),
              ],
            ),
            const SizedBox(height: 20),

            // Boutons pour les catégories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton("Popular Topic"),
                _buildCategoryButton("General"),
                _buildCategoryButton("Services"),
              ],
            ),
            const SizedBox(height: 20),

            // Contenu des questions
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFAQSection(), // Section FAQ
                  Center(child: Text("Contact Us Content")), // Section Contact Us
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bouton de catégorie
  Widget _buildCategoryButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.blueAccent),
      ),
    );
  }

  // Section FAQ avec des éléments expansibles
  Widget _buildFAQSection() {
    return ListView(
      children: [
        _buildFAQItem("Lorem ipsum dolor sit amet?", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Present pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam."),
        _buildFAQItem("Lorem ipsum dolor sit amet?", "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        _buildFAQItem("Lorem ipsum dolor sit amet?", "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        _buildFAQItem("Lorem ipsum dolor sit amet?", "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        _buildFAQItem("Lorem ipsum dolor sit amet?", "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
      ],
    );
  }

  // Élément FAQ individuel
  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: Colors.blue[50],
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                answer,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ],
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
