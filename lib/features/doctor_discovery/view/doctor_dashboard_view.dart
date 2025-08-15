import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/constant/string.dart';
import 'package:tabibak/features/doctor_discovery/services/user_mode_service.dart';

class DoctorDashboardView extends StatefulWidget {
  const DoctorDashboardView({super.key});

  @override
  State<DoctorDashboardView> createState() => _DoctorDashboardViewState();
}

class _DoctorDashboardViewState extends State<DoctorDashboardView> {
  int _selectedIndex = 0;
  bool _isOnline = true; // User mode status
  String _doctorName = 'Dr. Ahmed Hassan';
  String _specialty = 'Cardiology';
  String _location = 'Cairo, Egypt';
  
  final UserModeService _userModeService = UserModeService();

  @override
  void initState() {
    super.initState();
    _initializeUserMode();
  }

  @override
  void dispose() {
    _userModeService.dispose();
    super.dispose();
  }

  void _initializeUserMode() {
    _userModeService.initializeDoctorMode(
      doctorId: 'doctor_001',
      doctorName: _doctorName,
      specialty: _specialty,
      location: _location,
    );
    
    // Listen to user mode changes
    _userModeService.userModeStream.listen((userMode) {
      if (mounted) {
        setState(() {
          _isOnline = userMode.isOnline;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildQuickStatusFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsApp.kPrimaryColor,
      elevation: 0,
      title: Text(
        'Doctor Dashboard',
        style: GoogleFonts.montserrat(
          color: ColorsApp.kWhiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        // User Mode Status Toggle
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _isOnline ? Icons.circle : Icons.circle_outlined,
                color: _isOnline ? ColorsApp.kSuccessColor : ColorsApp.kGreyColor,
                size: 12,
              ),
              const SizedBox(width: 8),
              Text(
                _isOnline ? 'Online' : 'Offline',
                style: GoogleFonts.montserrat(
                  color: ColorsApp.kWhiteColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
                              Switch(
                  value: _isOnline,
                  onChanged: (value) {
                    setState(() {
                      _isOnline = value;
                    });
                    _userModeService.toggleOnlineStatus(value);
                    _showModeChangeSnackBar();
                  },
                  activeColor: ColorsApp.kSuccessColor,
                  activeTrackColor: ColorsApp.kWhiteColor.withOpacity(0.3),
                  inactiveThumbColor: ColorsApp.kGreyColor,
                  inactiveTrackColor: ColorsApp.kWhiteColor.withOpacity(0.2),
                ),
            ],
          ),
        ),
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
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildMainDashboard();
      case 1:
        return _buildAppointments();
      case 2:
        return _buildPatients();
      case 3:
        return _buildSchedule();
      default:
        return _buildMainDashboard();
    }
  }

  Widget _buildMainDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(),
          const SizedBox(height: 32),
          _buildQuickStats(),
          const SizedBox(height: 32),
          _buildQuickActions(),
          const SizedBox(height: 32),
          _buildRecentPatients(),
          const SizedBox(height: 32),
          _buildUpcomingAppointments(),
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
                  Icons.medical_services,
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
                      'Welcome back,',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: ColorsApp.kWhiteColor.withOpacity(0.9),
                      ),
                    ),
                    Text(
                      _doctorName,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.kWhiteColor,
                      ),
                    ),
                    Text(
                      _specialty,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: ColorsApp.kWhiteColor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
                        // Status indicator
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _isOnline 
                      ? ColorsApp.kSuccessColor 
                      : ColorsApp.kGreyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _isOnline ? 'ACTIVE' : 'INACTIVE',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.kWhiteColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _userModeService.getLastSeenText(),
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: ColorsApp.kWhiteColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: ColorsApp.kWhiteColor.withOpacity(0.9),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _location,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: ColorsApp.kWhiteColor.withOpacity(0.9),
                ),
              ),
              const Spacer(),
              Text(
                'You have 8 appointments today',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: ColorsApp.kWhiteColor.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Stats',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
            final childAspectRatio = constraints.maxWidth > 600 ? 1.2 : 1.5;
            
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
              children: [
                _buildStatCard(
                  'Today\'s Appointments',
                  '8',
                  Icons.calendar_today,
                  ColorsApp.kPrimaryColor,
                ),
                _buildStatCard(
                  'Active Patients',
                  '24',
                  Icons.people,
                  ColorsApp.kSuccessColor,
                ),
                _buildStatCard(
                  'Pending Reports',
                  '3',
                  Icons.description,
                  ColorsApp.kWarningColor,
                ),
                _buildStatCard(
                  'Total Earnings',
                  '2,450 EGP',
                  Icons.attach_money,
                  ColorsApp.kTealColor,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsApp.kTextColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: ColorsApp.kSecondaryTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
                  'View Schedule',
                  Icons.schedule,
                  ColorsApp.kPrimaryColor,
                  () => setState(() => _selectedIndex = 3),
                ),
                _buildActionCard(
                  'Patient Records',
                  Icons.folder,
                  ColorsApp.kSuccessColor,
                  () => Navigator.pushNamed(context, Routes.medicalFile),
                ),
                _buildActionCard(
                  'Chat Support',
                  Icons.chat,
                  ColorsApp.kTealColor,
                  () => Navigator.pushNamed(context, Routes.chat),
                ),
                _buildActionCard(
                  'Earnings Report',
                  Icons.analytics,
                  ColorsApp.kPurpleColor,
                  () => _showEarningsReport(),
                ),
                _buildActionCard(
                  'Settings',
                  Icons.settings,
                  ColorsApp.kOrangeColor,
                  () => Navigator.pushNamed(context, Routes.profile),
                ),
                _buildActionCard(
                  'Emergency',
                  Icons.emergency,
                  ColorsApp.kErrorColor,
                  () => _showEmergencyMode(),
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

  Widget _buildRecentPatients() {
    final recentPatients = [
      {
        'name': 'Ahmed Mohamed',
        'age': '35',
        'lastVisit': '2 days ago',
        'nextAppointment': 'Tomorrow, 10:00 AM',
        'status': 'Follow-up',
        'avatar': 'AM',
        'color': ColorsApp.kPrimaryColor,
      },
      {
        'name': 'Fatima Ali',
        'age': '28',
        'lastVisit': '1 week ago',
        'nextAppointment': 'Dec 25, 2:30 PM',
        'status': 'New Patient',
        'avatar': 'FA',
        'color': ColorsApp.kSuccessColor,
      },
      {
        'name': 'Omar Khalil',
        'age': '42',
        'lastVisit': '3 days ago',
        'nextAppointment': 'Dec 23, 9:00 AM',
        'status': 'Consultation',
        'avatar': 'OK',
        'color': ColorsApp.kTealColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Patients',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorsApp.kTextColor,
              ),
            ),
            TextButton(
              onPressed: () => setState(() => _selectedIndex = 2),
              child: Text(
                'View All',
                style: GoogleFonts.montserrat(
                  color: ColorsApp.kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
            itemCount: recentPatients.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: ColorsApp.kLightGreyColor,
            ),
            itemBuilder: (context, index) {
              final patient = recentPatients[index];
              return _buildPatientCard(patient);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: patient['color'].withOpacity(0.1),
        child: Text(
          patient['avatar'],
          style: GoogleFonts.montserrat(
            color: patient['color'],
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      title: Text(
        patient['name'],
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorsApp.kTextColor,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Age: ${patient['age']} | ${patient['status']}',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: ColorsApp.kSecondaryTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Next: ${patient['nextAppointment']}',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: ColorsApp.kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: patient['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          patient['status'],
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: patient['color'],
          ),
        ),
      ),
      onTap: () => _viewPatientDetails(patient),
    );
  }

  Widget _buildUpcomingAppointments() {
    final upcomingAppointments = [
      {
        'patient': 'Ahmed Mohamed',
        'time': '10:00 AM',
        'type': 'Follow-up',
        'status': 'Confirmed',
        'color': ColorsApp.kSuccessColor,
      },
      {
        'patient': 'Fatima Ali',
        'time': '2:30 PM',
        'type': 'New Patient',
        'status': 'Confirmed',
        'color': ColorsApp.kSuccessColor,
      },
      {
        'patient': 'Omar Khalil',
        'time': '4:00 PM',
        'type': 'Consultation',
        'status': 'Pending',
        'color': ColorsApp.kWarningColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s Appointments',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorsApp.kTextColor,
              ),
            ),
            TextButton(
              onPressed: () => setState(() => _selectedIndex = 1),
              child: Text(
                'View All',
                style: GoogleFonts.montserrat(
                  color: ColorsApp.kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
            itemCount: upcomingAppointments.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: ColorsApp.kLightGreyColor,
            ),
            itemBuilder: (context, index) {
              final appointment = upcomingAppointments[index];
              return _buildAppointmentCard(appointment);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      leading: Container(
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
      title: Text(
        appointment['patient'],
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorsApp.kTextColor,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${appointment['time']} - ${appointment['type']}',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: ColorsApp.kSecondaryTextColor,
            ),
          ),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: appointment['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          appointment['status'],
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: appointment['color'],
          ),
        ),
      ),
      onTap: () => _viewAppointmentDetails(appointment),
    );
  }

  Widget _buildAppointments() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointments',
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 20),
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
                    'Appointments View',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.kTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Detailed appointments view coming soon',
                    style: TextStyle(
                      color: ColorsApp.kSecondaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatients() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patients',
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people,
                    size: 80,
                    color: ColorsApp.kPrimaryColor,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Patients Management',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.kTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Patient management system coming soon',
                    style: TextStyle(
                      color: ColorsApp.kSecondaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedule() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schedule',
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    size: 80,
                    color: ColorsApp.kPrimaryColor,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Schedule Management',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.kTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Schedule management system coming soon',
                    style: TextStyle(
                      color: ColorsApp.kSecondaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
        ],
      ),
    );
  }

  void _showModeChangeSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isOnline 
              ? 'You are now ONLINE and visible to patients'
              : 'You are now OFFLINE and hidden from patients',
        ),
        backgroundColor: _isOnline ? ColorsApp.kSuccessColor : ColorsApp.kGreyColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showEarningsReport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Earnings Report',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This month: 2,450 EGP',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: ColorsApp.kTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Last month: 2,100 EGP',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: ColorsApp.kSecondaryTextColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: ColorsApp.kPrimaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEmergencyMode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Emergency Mode',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kErrorColor,
            ),
          ),
          content: Text(
            'Emergency mode allows you to receive urgent patient requests and notifications.',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kTextColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: ColorsApp.kSecondaryTextColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _enableEmergencyMode();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.kErrorColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Enable',
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

  void _enableEmergencyMode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Emergency mode enabled! You will receive urgent notifications.'),
        backgroundColor: ColorsApp.kErrorColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _viewPatientDetails(Map<String, dynamic> patient) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing details for ${patient['name']}'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _viewAppointmentDetails(Map<String, dynamic> appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing appointment with ${appointment['patient']}'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  Widget _buildQuickStatusFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _isOnline ? ColorsApp.kSuccessColor : ColorsApp.kGreyColor,
            _isOnline ? ColorsApp.kPrimaryColor : ColorsApp.kSecondaryTextColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (_isOnline ? ColorsApp.kSuccessColor : ColorsApp.kGreyColor).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          final newStatus = !_isOnline;
          setState(() {
            _isOnline = newStatus;
          });
          _userModeService.toggleOnlineStatus(newStatus);
          _showModeChangeSnackBar();
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Icon(
          _isOnline ? Icons.visibility : Icons.visibility_off,
          color: ColorsApp.kWhiteColor,
          size: 28,
        ),
      ),
    );
  }
}
