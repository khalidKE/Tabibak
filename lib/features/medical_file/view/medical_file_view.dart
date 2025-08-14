import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';

class MedicalFileView extends StatefulWidget {
  const MedicalFileView({super.key});

  @override
  State<MedicalFileView> createState() => _MedicalFileViewState();
}

class _MedicalFileViewState extends State<MedicalFileView> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsApp.kPrimaryColor,
        elevation: 0,
        title: Text(
          'Medical File',
          style: GoogleFonts.montserrat(
            color: ColorsApp.kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsApp.kWhiteColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: ColorsApp.kWhiteColor),
            onPressed: () => _showAddRecordDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: ColorsApp.kWhiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          _buildTab('History', 0),
          const SizedBox(width: 16),
          _buildTab('Prescriptions', 1),
          const SizedBox(width: 16),
          _buildTab('Reports', 2),
          const SizedBox(width: 16),
          _buildTab('Allergies', 3),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? ColorsApp.kPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? ColorsApp.kPrimaryColor : ColorsApp.kLightGreyColor,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? ColorsApp.kWhiteColor : ColorsApp.kTextColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildMedicalHistory();
      case 1:
        return _buildPrescriptions();
      case 2:
        return _buildReports();
      case 3:
        return _buildAllergies();
      default:
        return _buildMedicalHistory();
    }
  }

  Widget _buildMedicalHistory() {
    final medicalHistory = [
      {
        'date': '15 Dec 2024',
        'doctor': 'Dr. Sarah Ahmed',
        'specialty': 'Cardiology',
        'diagnosis': 'Hypertension',
        'treatment': 'Lifestyle changes, medication monitoring',
        'status': 'Active',
        'color': ColorsApp.kWarningColor,
      },
      {
        'date': '10 Nov 2024',
        'doctor': 'Dr. Mohamed Hassan',
        'specialty': 'Dermatology',
        'diagnosis': 'Eczema',
        'treatment': 'Topical cream, avoid triggers',
        'status': 'Resolved',
        'color': ColorsApp.kSuccessColor,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: medicalHistory.length,
      itemBuilder: (context, index) {
        final record = medicalHistory[index];
        return _buildHistoryCard(record);
      },
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ColorsApp.kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: record['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.medical_services,
                    color: record['color'],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record['diagnosis'],
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.kTextColor,
                        ),
                      ),
                      Text(
                        record['specialty'],
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: ColorsApp.kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: record['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    record['status'],
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: record['color'],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Doctor', record['doctor']),
            _buildInfoRow('Date', record['date']),
            _buildInfoRow('Treatment', record['treatment']),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showRecordDetails(record),
                    icon: Icon(Icons.visibility, color: ColorsApp.kPrimaryColor),
                    label: Text(
                      'View Details',
                      style: GoogleFonts.montserrat(
                        color: ColorsApp.kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: ColorsApp.kPrimaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _bookFollowUp(record),
                    icon: Icon(Icons.calendar_today, color: ColorsApp.kWhiteColor),
                    label: Text(
                      'Book Follow-up',
                      style: GoogleFonts.montserrat(
                        color: ColorsApp.kWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.kPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorsApp.kSecondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorsApp.kTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medication,
            size: 80,
            color: ColorsApp.kPrimaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'Prescriptions',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your medication prescriptions will appear here',
            style: TextStyle(
              color: ColorsApp.kSecondaryTextColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReports() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description,
            size: 80,
            color: ColorsApp.kPrimaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'Medical Reports',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your lab results and medical reports will appear here',
            style: TextStyle(
              color: ColorsApp.kSecondaryTextColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergies() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            size: 80,
            color: ColorsApp.kPrimaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'Allergies',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your known allergies and reactions will appear here',
            style: TextStyle(
              color: ColorsApp.kSecondaryTextColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddRecordDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add record functionality coming soon'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _showRecordDetails(Map<String, dynamic> record) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing details for ${record['diagnosis']}'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _bookFollowUp(Map<String, dynamic> record) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking follow-up for ${record['diagnosis']}'),
        backgroundColor: ColorsApp.kSuccessColor,
      ),
    );
  }
}
