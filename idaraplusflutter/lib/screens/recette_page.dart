import 'package:flutter/material.dart';
import '../models/tunisia_data.dart';

class RecettePage extends StatefulWidget {
  const RecettePage({super.key});

  @override
  RecuttePageState createState() => RecuttePageState();
}

class RecuttePageState extends State<RecettePage> {
  String? selectedWilaya;
  String? selectedArea;
  String? selectedRecette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        title: const Text('Recette des Finances'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // Wilaya Selection
              const Text(
                'Sélectionner une Wilaya',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD0D0D0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedWilaya,
                  isExpanded: true,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Choisir une Wilaya'),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedWilaya = newValue;
                      selectedArea = null;
                      selectedRecette = null;
                    });
                  },
                  underline: const SizedBox(),
                  items: TunisiaData.wilayet
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Area Selection
              const Text(
                'Sélectionner une Zone',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedWilaya == null ? Color(0xFFC0C0C0) : Color(0xFFD0D0D0),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedArea,
                  isExpanded: true,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Choisir une Zone'),
                  ),
                  onChanged: selectedWilaya == null
                      ? null
                      : (String? newValue) {
                          setState(() {
                            selectedArea = newValue;
                            selectedRecette = null;
                          });
                        },
                  underline: const SizedBox(),
                  items: selectedWilaya == null
                      ? []
                      : TunisiaData.getAreasByWilaya(selectedWilaya!)
                          .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Recette Selection
              const Text(
                'Sélectionner une Recette',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedArea == null ? Color(0xFFC0C0C0) : Color(0xFFD0D0D0),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedRecette,
                  isExpanded: true,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Choisir une Recette'),
                  ),
                  onChanged: selectedArea == null
                      ? null
                      : (String? newValue) {
                          setState(() {
                            selectedRecette = newValue;
                          });
                        },
                  underline: const SizedBox(),
                  items: selectedArea == null
                      ? []
                      : (TunisiaData.administrationsByArea[selectedArea] ?? [])
                          .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Actions
              const Text(
                'Actions Disponibles',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 20),
              
              _buildActionButton('Paiements Fiscaux', Icons.credit_card),
              _buildActionButton('Déclarations Fiscales', Icons.description),
              _buildActionButton('Consultations Fiscales', Icons.help),
              _buildActionButton('Achat Timbre', Icons.receipt_long),
              _buildActionButton('Horaires d\'ouverture', Icons.schedule),
              _buildActionButton('Contacter la Recette', Icons.phone),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(label),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, color: Color(0xFF1976D2), size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward, color: Color(0xFF1976D2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
