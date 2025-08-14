import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/constant/string.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _userRole = 'patient'; // This would come from user data
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsApp.kPrimaryColor,
        elevation: 0,
        title: Text(
          'Profile',
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
            icon: const Icon(Icons.edit, color: ColorsApp.kWhiteColor),
            onPressed: () {
              // TODO: Navigate to edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildProfileInfo(),
            const SizedBox(height: 24),
            _buildSettings(),
            const SizedBox(height: 24),
            _buildActions(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsApp.kPrimaryColor, ColorsApp.kTealColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Profile Picture
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: ColorsApp.kWhiteColor.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorsApp.kWhiteColor.withOpacity(0.3),
                width: 3,
              ),
            ),
            child: Icon(
              _userRole == 'doctor' ? Icons.medical_services : Icons.person,
              size: 50,
              color: ColorsApp.kWhiteColor,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Name and Role
          Text(
            _userRole == 'doctor' ? 'Dr. Ahmed Hassan' : 'Ahmed Hassan',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kWhiteColor,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            _userRole == 'doctor' ? 'Cardiologist' : 'Patient',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kWhiteColor.withOpacity(0.9),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                _userRole == 'doctor' ? 'Patients' : 'Appointments',
                _userRole == 'doctor' ? '156' : '23',
                Icons.people,
              ),
              _buildStatItem(
                _userRole == 'doctor' ? 'Experience' : 'Visits',
                _userRole == 'doctor' ? '15 years' : '12',
                Icons.timeline,
              ),
              _buildStatItem(
                'Rating',
                '4.9',
                Icons.star,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: ColorsApp.kWhiteColor.withOpacity(0.8),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kWhiteColor,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: ColorsApp.kWhiteColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoCard([
            _buildInfoRow('Full Name', 'Ahmed Hassan Mohamed'),
            _buildInfoRow('Phone', '+20 123 456 7890'),
            _buildInfoRow('Email', 'ahmed.hassan@email.com'),
            _buildInfoRow('Date of Birth', '15 March 1985'),
            _buildInfoRow('Gender', 'Male'),
            if (_userRole == 'doctor') ...[
              _buildInfoRow('Specialization', 'Cardiology'),
              _buildInfoRow('License Number', 'MD-12345-EG'),
              _buildInfoRow('Hospital', 'Cairo Medical Center'),
            ] else ...[
              _buildInfoRow('Blood Type', 'O+'),
              _buildInfoRow('Emergency Contact', '+20 987 654 3210'),
            ],
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
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
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
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

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 16),
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
            child: Column(
              children: [
                _buildSettingTile(
                  'Notifications',
                  'Receive appointment reminders and updates',
                  Icons.notifications,
                  ColorsApp.kAccentColor,
                  Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: ColorsApp.kPrimaryColor,
                  ),
                ),
                Divider(height: 1, color: ColorsApp.kLightGreyColor),
                _buildSettingTile(
                  'Location Services',
                  'Allow app to access your location for nearby doctors',
                  Icons.location_on,
                  ColorsApp.kTealColor,
                  Switch(
                    value: _locationEnabled,
                    onChanged: (value) {
                      setState(() {
                        _locationEnabled = value;
                      });
                    },
                    activeColor: ColorsApp.kPrimaryColor,
                  ),
                ),
                Divider(height: 1, color: ColorsApp.kLightGreyColor),
                _buildSettingTile(
                  'Language',
                  'English',
                  Icons.language,
                  ColorsApp.kPurpleColor,
                  Row(
                    children: [
                      Text(
                        'English',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: ColorsApp.kSecondaryTextColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: ColorsApp.kSecondaryTextColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: ColorsApp.kLightGreyColor),
                _buildSettingTile(
                  'Privacy Policy',
                  'Read our privacy policy and terms of service',
                  Icons.privacy_tip,
                  ColorsApp.kOrangeColor,
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: ColorsApp.kSecondaryTextColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    Widget trailing,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorsApp.kTextColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.montserrat(
          fontSize: 12,
          color: ColorsApp.kSecondaryTextColor,
        ),
      ),
      trailing: trailing,
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actions',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
                             _buildActionButton(
                 'Edit Profile',
                 Icons.edit,
                 ColorsApp.kPrimaryColor,
                 () {
                   _showEditProfileDialog();
                 },
               ),
               const SizedBox(height: 12),
               _buildActionButton(
                 'Change Password',
                 Icons.lock,
                 ColorsApp.kAccentColor,
                 () {
                   _showChangePasswordDialog();
                 },
               ),
               const SizedBox(height: 12),
               _buildActionButton(
                 'Help & Support',
                 Icons.help,
                 ColorsApp.kTealColor,
                 () {
                   _showHelpSupportDialog();
                 },
               ),
               const SizedBox(height: 12),
               _buildActionButton(
                 'About App',
                 Icons.info,
                 ColorsApp.kPurpleColor,
                 () {
                   _showAboutAppDialog();
                 },
               ),
              const SizedBox(height: 12),
              _buildActionButton(
                'Logout',
                Icons.logout,
                ColorsApp.kErrorColor,
                () {
                  _showLogoutDialog();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        label: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: color),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kSecondaryTextColor,
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
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.kErrorColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
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

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Edit Profile',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          content: Text(
            'Profile editing functionality coming soon!',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kSecondaryTextColor,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
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

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Change Password',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          content: Text(
            'Password change functionality coming soon!',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kSecondaryTextColor,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
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

  void _showHelpSupportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Help & Support',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          content: Text(
            'Help and support functionality coming soon!',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kSecondaryTextColor,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
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

  void _showAboutAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'About Tabibak',
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
                'Version: 1.0.0',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.kTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tabibak is a comprehensive medical appointment and case management system designed to streamline healthcare services.',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: ColorsApp.kSecondaryTextColor,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
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
}
