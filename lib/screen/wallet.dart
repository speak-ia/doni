import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Portefeuille',
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Total balance card
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total solde',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '150.000 fcfa',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '+5000',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), backgroundColor: Color(0xff0A1B34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ), // couleur du bouton
                        ),
                        child: Text('Encaisser', style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dernière opération',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.keyboard_arrow_up),
                ],
              ),
            ),

            // Liste des opérations
            SizedBox(height: 16),
            _buildOperationCard(
              title: 'Enquête 325',
              amount: '+5000 F',
              status: 'Validé',
              statusColor: Colors.green,
              logo: 'assets/images/top3.png',
            ),
            _buildOperationCard(
              title: 'Enquête 326',
              amount: '+10.000 F',
              status: 'Validé',
              statusColor: Colors.green,
              logo: 'assets/images/top2.png',
            ),
            _buildOperationCard(
              title: 'Enquête 327',
              amount: '+5.000 F',
              status: 'Traitement en cours',
              statusColor: Colors.red,
              logo: 'assets/images/top1.png',
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour créer les cartes des opérations
  Widget _buildOperationCard({
    required String title,
    required String amount,
    required String status,
    required Color statusColor,
    required String logo,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          // Logo de l'enquête
          CircleAvatar(
            backgroundImage: AssetImage(logo),
            radius: 24,
          ),
          SizedBox(width: 16),
          // Informations sur l'opération
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Dans un monde compétitif, \nil est utile d'avoir une grande quantité d'informations à sa disposition.",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          // Montant et statut
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                status,
                style: TextStyle(fontSize: 14, color: statusColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
