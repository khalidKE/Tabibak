import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/constant/string.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _userRole = 'patient'; // Default role, can be changed based on login
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsApp.kPrimaryColor,
        elevation: 0,
        title: Text(
          'Tabibak',
          style: GoogleFonts.montserrat(
            color: ColorsApp.kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: ColorsApp.kWhiteColor),
            onPressed: () {
              // TODO: Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: ColorsApp.kWhiteColor),
            onPressed: () {
              Navigator.pushNamed(context, Routes.profile);
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildChatbotFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildAppointments();
      case 2:
        return _buildMedicalFile();
      case 3:
        return _buildChat();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(),
          const SizedBox(height: 32),
          _buildQuickActions(),
          const SizedBox(height: 32),
          _buildRecentActivity(),
          const SizedBox(height: 32),
          _buildHealthTips(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsApp.kPrimaryColor, ColorsApp.kTealColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorsApp.kPrimaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ColorsApp.kWhiteColor.withOpacity(0.2),
                child: Icon(
                  _userRole == 'doctor' ? Icons.medical_services : Icons.person,
                  size: 30,
                  color: ColorsApp.kWhiteColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: ColorsApp.kWhiteColor.withOpacity(0.9),
                      ),
                    ),
                    Text(
                      _userRole == 'doctor' ? 'Dr. Ahmed' : 'Ahmed',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _userRole == 'doctor' 
                ? 'You have 5 appointments today'
                : 'How can we help you today?',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kWhiteColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
            final childAspectRatio = constraints.maxWidth > 600 ? 1.0 : 1.2;
            
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
              children: [
                _buildActionCard(
                  'Find Doctors',
                  Icons.search,
                  ColorsApp.kAccentColor,
                  () => Navigator.pushNamed(context, Routes.doctorDiscovery),
                ),
                _buildActionCard(
                  'Book Appointment',
                  Icons.calendar_today,
                  ColorsApp.kSuccessColor,
                  () => Navigator.pushNamed(context, Routes.appointmentBooking),
                ),
                _buildActionCard(
                  'Medical File',
                  Icons.folder,
                  ColorsApp.kPurpleColor,
                  () => Navigator.pushNamed(context, Routes.medicalFile),
                ),
                _buildActionCard(
                  'Symptom Checker',
                  Icons.psychology,
                  ColorsApp.kOrangeColor,
                  () => Navigator.pushNamed(context, Routes.symptomChecker),
                ),
                _buildActionCard(
                  'Nearby Doctors',
                  Icons.location_on,
                  ColorsApp.kTealColor,
                  () => Navigator.pushNamed(context, Routes.nearbyDoctors),
                ),
                _buildActionCard(
                  'Chat Support',
                  Icons.chat,
                  ColorsApp.kPinkColor,
                  () => Navigator.pushNamed(context, Routes.chat),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsApp.kWhiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorsApp.kTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 20),
        Container(
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
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: ColorsApp.kLightGreyColor,
            ),
            itemBuilder: (context, index) {
              final activities = [
                {'title': 'Appointment Booked', 'subtitle': 'Dr. Sarah - Cardiology', 'time': '2 hours ago', 'icon': Icons.calendar_today, 'color': ColorsApp.kSuccessColor},
                {'title': 'Medical Report', 'subtitle': 'Blood test results ready', 'time': '1 day ago', 'icon': Icons.description, 'color': ColorsApp.kInfoColor},
                {'title': 'Prescription', 'subtitle': 'New medication prescribed', 'time': '2 days ago', 'icon': Icons.medication, 'color': ColorsApp.kWarningColor},
              ];
              
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (activities[index]['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    activities[index]['icon'] as IconData,
                    color: activities[index]['color'] as Color,
                    size: 20,
                  ),
                ),
                title: Text(
                  activities[index]['title'] as String,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.kTextColor,
                  ),
                ),
                subtitle: Text(
                  activities[index]['subtitle'] as String,
                  style: TextStyle(
                    color: ColorsApp.kSecondaryTextColor,
                    fontSize: 14,
                  ),
                ),
                trailing: Text(
                  activities[index]['time'] as String,
                  style: TextStyle(
                    color: ColorsApp.kSecondaryTextColor,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHealthTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Tips',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorsApp.kLimeColor, ColorsApp.kGreenColor ?? ColorsApp.kSuccessColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb,
                size: 40,
                color: ColorsApp.kWhiteColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stay Hydrated!',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.kWhiteColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Drink 8 glasses of water daily for better health and energy.',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: ColorsApp.kWhiteColor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointments() {
    final upcomingAppointments = [
      {
        'doctor': 'Dr. Sarah Ahmed',
        'specialty': 'Cardiology',
        'date': 'Tomorrow, 10:00 AM',
        'type': 'Follow-up',
        'status': 'Confirmed',
        'color': ColorsApp.kSuccessColor,
      },
      {
        'doctor': 'Dr. Mohamed Hassan',
        'specialty': 'Dermatology',
        'date': 'Dec 20, 2:30 PM',
        'type': 'Consultation',
        'status': 'Pending',
        'color': ColorsApp.kWarningColor,
      },
      {
        'doctor': 'Dr. Fatima Ali',
        'specialty': 'General Medicine',
        'date': 'Dec 22, 9:00 AM',
        'type': 'Check-up',
        'status': 'Confirmed',
        'color': ColorsApp.kSuccessColor,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointments',
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.kTextColor,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, Routes.appointmentBooking),
                icon: Icon(Icons.add, color: ColorsApp.kWhiteColor),
                label: Text(
                  'Book New',
                  style: GoogleFonts.montserrat(
                    color: ColorsApp.kWhiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsApp.kPrimaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (upcomingAppointments.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 80,
                      color: ColorsApp.kPrimaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No Upcoming Appointments',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.kTextColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Book your first appointment to get started',
                      style: TextStyle(
                        color: ColorsApp.kSecondaryTextColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, Routes.appointmentBooking),
                      icon: Icon(Icons.calendar_today, color: ColorsApp.kWhiteColor),
                      label: Text(
                        'Book Appointment',
                        style: GoogleFonts.montserrat(
                          color: ColorsApp.kWhiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.kPrimaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: upcomingAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = upcomingAppointments[index];
                  return _buildAppointmentCard(appointment);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: appointment['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: appointment['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['doctor'],
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.kTextColor,
                        ),
                      ),
                      Text(
                        appointment['specialty'],
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: ColorsApp.kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        appointment['date'],
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: ColorsApp.kSecondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: appointment['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    appointment['status'],
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: appointment['color'],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _rescheduleAppointment(appointment),
                    icon: Icon(Icons.schedule, color: ColorsApp.kPrimaryColor),
                    label: Text(
                      'Reschedule',
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
                    onPressed: () => _cancelAppointment(appointment),
                    icon: Icon(Icons.cancel, color: ColorsApp.kWhiteColor),
                    label: Text(
                      'Cancel',
                      style: GoogleFonts.montserrat(
                        color: ColorsApp.kWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.kErrorColor,
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

  Widget _buildMedicalFile() {
    final recentRecords = [
      {
        'type': 'Blood Test',
        'date': 'Dec 15, 2024',
        'status': 'Available',
        'icon': Icons.bloodtype,
        'color': ColorsApp.kSuccessColor,
      },
      {
        'type': 'X-Ray Chest',
        'date': 'Dec 10, 2024',
        'status': 'Available',
        'icon': Icons.medical_services,
        'color': ColorsApp.kSuccessColor,
      },
      {
        'type': 'ECG Report',
        'date': 'Dec 5, 2024',
        'status': 'Available',
        'icon': Icons.favorite,
        'color': ColorsApp.kSuccessColor,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medical File',
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.kTextColor,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, Routes.medicalFile),
                icon: Icon(Icons.folder_open, color: ColorsApp.kWhiteColor),
                label: Text(
                  'View All',
                  style: GoogleFonts.montserrat(
                    color: ColorsApp.kWhiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsApp.kPrimaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (recentRecords.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder,
                      size: 80,
                      color: ColorsApp.kPrimaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No Medical Records',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.kTextColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your medical records will appear here',
                      style: TextStyle(
                        color: ColorsApp.kSecondaryTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: recentRecords.length,
                itemBuilder: (context, index) {
                  final record = recentRecords[index];
                  return _buildMedicalRecordCard(record);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMedicalRecordCard(Map<String, dynamic> record) {
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: record['color'].withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            record['icon'],
            color: record['color'],
            size: 24,
          ),
        ),
        title: Text(
          record['type'],
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        subtitle: Text(
          'Date: ${record['date']}',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: ColorsApp.kSecondaryTextColor,
          ),
        ),
        trailing: Container(
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
        onTap: () => _viewMedicalRecord(record),
      ),
    );
  }

  Widget _buildChat() {
    final recentChats = [
      {
        'doctor': 'Dr. Sarah Ahmed',
        'specialty': 'Cardiology',
        'lastMessage': 'How are you feeling today?',
        'time': '2 min ago',
        'unread': 1,
        'avatar': 'SA',
        'color': ColorsApp.kPrimaryColor,
      },
      {
        'doctor': 'Dr. Mohamed Hassan',
        'specialty': 'Dermatology',
        'lastMessage': 'The cream should help with the rash',
        'time': '1 hour ago',
        'unread': 0,
        'avatar': 'MH',
        'color': ColorsApp.kTealColor,
      },
      {
        'doctor': 'Dr. Fatima Ali',
        'specialty': 'General Medicine',
        'lastMessage': 'Your test results are ready',
        'time': '3 hours ago',
        'unread': 0,
        'avatar': 'FA',
        'color': ColorsApp.kPurpleColor,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chat Support',
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.kTextColor,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, Routes.chat),
                icon: Icon(Icons.chat, color: ColorsApp.kWhiteColor),
                label: Text(
                  'New Chat',
                  style: GoogleFonts.montserrat(
                    color: ColorsApp.kWhiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsApp.kPrimaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (recentChats.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat,
                      size: 80,
                      color: ColorsApp.kPrimaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No Recent Chats',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.kTextColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Start a conversation with your doctor',
                      style: TextStyle(
                        color: ColorsApp.kSecondaryTextColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, Routes.chat),
                      icon: Icon(Icons.chat, color: ColorsApp.kWhiteColor),
                      label: Text(
                        'Start Chat',
                        style: GoogleFonts.montserrat(
                          color: ColorsApp.kWhiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.kPrimaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: recentChats.length,
                itemBuilder: (context, index) {
                  final chat = recentChats[index];
                  return _buildChatCard(chat);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChatCard(Map<String, dynamic> chat) {
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: chat['color'].withOpacity(0.1),
              child: Text(
                chat['avatar'],
                style: GoogleFonts.montserrat(
                  color: chat['color'],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            if (chat['unread'] > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ColorsApp.kErrorColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chat['unread'].toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.kWhiteColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          chat['doctor'],
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat['specialty'],
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: ColorsApp.kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              chat['lastMessage'],
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: ColorsApp.kSecondaryTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Text(
          chat['time'],
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: ColorsApp.kSecondaryTextColor,
          ),
        ),
        onTap: () => _openChat(chat),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorsApp.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorsApp.kWhiteColor,
        selectedItemColor: ColorsApp.kPrimaryColor,
        unselectedItemColor: ColorsApp.kSecondaryTextColor,
        selectedLabelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Medical File',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }

  void _rescheduleAppointment(Map<String, dynamic> appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rescheduling appointment with ${appointment['doctor']}'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _cancelAppointment(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Cancel Appointment',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          content: Text(
            'Are you sure you want to cancel your appointment with ${appointment['doctor']}?',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kSecondaryTextColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'No, Keep It',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: ColorsApp.kSecondaryTextColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Appointment with ${appointment['doctor']} cancelled'),
                    backgroundColor: ColorsApp.kSuccessColor,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.kErrorColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Yes, Cancel',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.kWhiteColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _viewMedicalRecord(Map<String, dynamic> record) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing ${record['type']} record'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _openChat(Map<String, dynamic> chat) {
    Navigator.pushNamed(context, Routes.chat);
  }

  Widget _buildChatbotFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsApp.kPrimaryColor, ColorsApp.kTealColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ColorsApp.kPrimaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () => _openChatbot(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Stack(
          children: [
            Icon(
              Icons.chat_bubble,
              color: ColorsApp.kWhiteColor,
              size: 28,
            ),
            // Notification indicator
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: ColorsApp.kErrorColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorsApp.kWhiteColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openChatbot() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildChatbotSheet(),
    );
  }

  Widget _buildChatbotSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: ColorsApp.kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: ColorsApp.kLightGreyColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsApp.kPrimaryColor, ColorsApp.kTealColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorsApp.kWhiteColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.smart_toy,
                    color: ColorsApp.kWhiteColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Medical Assistant',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.kWhiteColor,
                        ),
                      ),
                      Text(
                        'Ask me anything about your health',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: ColorsApp.kWhiteColor.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: ColorsApp.kWhiteColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // Chat content
          Expanded(
            child: _buildChatbotContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildChatbotContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Quick actions
          _buildChatbotQuickActions(),
          const SizedBox(height: 20),
          // Chat input
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildChatbotQuickActions() {
    final quickActions = [
      {'title': 'Check Symptoms', 'icon': Icons.psychology, 'color': ColorsApp.kPrimaryColor},
      {'title': 'Find Doctors', 'icon': Icons.search, 'color': ColorsApp.kAccentColor},
      {'title': 'Book Appointment', 'icon': Icons.calendar_today, 'color': ColorsApp.kSuccessColor},
      {'title': 'Medical Advice', 'icon': Icons.medical_services, 'color': ColorsApp.kTealColor},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: quickActions.length,
          itemBuilder: (context, index) {
            final action = quickActions[index];
            return _buildQuickActionCard(action);
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: () => _handleQuickAction(action['title']),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsApp.kWhiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: action['color'].withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: action['color'].withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: action['color'].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  action['icon'],
                  color: action['color'],
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  action['title'],
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.kTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsApp.kBackgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorsApp.kLightGreyColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ask me about your health...',
                hintStyle: TextStyle(color: ColorsApp.kSecondaryTextColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: (value) => _handleChatMessage(value),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: ColorsApp.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: ColorsApp.kWhiteColor,
                size: 20,
              ),
              onPressed: () => _handleChatMessage(''),
              constraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String action) {
    Navigator.pop(context);
    switch (action) {
      case 'Check Symptoms':
        Navigator.pushNamed(context, Routes.symptomChecker);
        break;
      case 'Find Doctors':
        Navigator.pushNamed(context, Routes.doctorDiscovery);
        break;
      case 'Book Appointment':
        Navigator.pushNamed(context, Routes.appointmentBooking);
        break;
      case 'Medical Advice':
        Navigator.pushNamed(context, Routes.chat);
        break;
    }
  }

  void _handleChatMessage(String message) {
    if (message.trim().isNotEmpty) {
      // TODO: Implement AI chat functionality
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('AI chat functionality coming soon!'),
          backgroundColor: ColorsApp.kInfoColor,
        ),
      );
    }
  }
}
