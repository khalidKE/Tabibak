import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';

class NearbyDoctorsView extends StatefulWidget {
  const NearbyDoctorsView({super.key});

  @override
  State<NearbyDoctorsView> createState() => _NearbyDoctorsViewState();
}

class _NearbyDoctorsViewState extends State<NearbyDoctorsView> {
  String _selectedSpecialty = 'All';
  String _selectedDistance = '5 km';
  bool _isLoading = false;

  final List<String> _specialties = [
    'All',
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'General Medicine',
    'Emergency Medicine',
  ];

  final List<String> _distances = [
    '1 km',
    '3 km',
    '5 km',
    '10 km',
    '20 km',
  ];

  final List<Map<String, dynamic>> _nearbyDoctors = [
    {
      'name': 'Dr. Sarah Ahmed',
      'specialty': 'Cardiology',
      'hospital': 'Cairo Medical Center',
      'distance': '0.8 km',
      'rating': 4.9,
      'experience': '15 years',
      'availability': 'Available Now',
      'avatar': 'SA',
      'color': ColorsApp.kPrimaryColor,
      'isAvailable': true,
    },
    {
      'name': 'Dr. Mohamed Hassan',
      'specialty': 'Dermatology',
      'hospital': 'Al Shifa Hospital',
      'distance': '1.2 km',
      'rating': 4.7,
      'experience': '12 years',
      'availability': 'Available in 30 min',
      'avatar': 'MH',
      'color': ColorsApp.kTealColor,
      'isAvailable': true,
    },
    {
      'name': 'Dr. Fatima Ali',
      'specialty': 'General Medicine',
      'hospital': 'Dar Al Fouad Hospital',
      'distance': '2.1 km',
      'rating': 4.8,
      'experience': '18 years',
      'availability': 'Available Now',
      'avatar': 'FA',
      'color': ColorsApp.kPurpleColor,
      'isAvailable': true,
    },
    {
      'name': 'Dr. Ahmed Omar',
      'specialty': 'Neurology',
      'hospital': 'Cairo University Hospital',
      'distance': '3.5 km',
      'rating': 4.6,
      'experience': '20 years',
      'availability': 'Available in 1 hour',
      'avatar': 'AO',
      'color': ColorsApp.kIndigoColor,
      'isAvailable': true,
    },
    {
      'name': 'Dr. Nour El Din',
      'specialty': 'Emergency Medicine',
      'hospital': 'Emergency Care Center',
      'distance': '0.5 km',
      'rating': 4.9,
      'experience': '8 years',
      'availability': 'Available Now',
      'avatar': 'NE',
      'color': ColorsApp.kErrorColor,
      'isAvailable': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsApp.kPrimaryColor,
        elevation: 0,
        title: Text(
          'Nearby Doctors',
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
            icon: const Icon(Icons.my_location, color: ColorsApp.kWhiteColor),
            onPressed: () => _getCurrentLocation(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _buildDoctorsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      color: ColorsApp.kWhiteColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  'Specialty',
                  _selectedSpecialty,
                  _specialties,
                  (value) => setState(() => _selectedSpecialty = value!),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFilterDropdown(
                  'Distance',
                  _selectedDistance,
                  _distances,
                  (value) => setState(() => _selectedDistance = value!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _applyFilters,
                  icon: Icon(Icons.search, color: ColorsApp.kWhiteColor),
                  label: Text(
                    'Search',
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
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _refreshResults,
                  icon: Icon(Icons.refresh, color: ColorsApp.kPrimaryColor),
                  label: Text(
                    'Refresh',
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: ColorsApp.kBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorsApp.kLightGreyColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: ColorsApp.kPrimaryColor),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: ColorsApp.kTextColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorsApp.kPrimaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            'Finding nearby doctors...',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kSecondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList() {
    final filteredDoctors = _getFilteredDoctors();

    if (filteredDoctors.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredDoctors.length,
      itemBuilder: (context, index) {
        final doctor = filteredDoctors[index];
        return _buildDoctorCard(doctor);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 80,
            color: ColorsApp.kSecondaryTextColor,
          ),
          const SizedBox(height: 24),
          Text(
            'No doctors found nearby',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorsApp.kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try adjusting your filters or expanding the search area',
            style: TextStyle(
              color: ColorsApp.kSecondaryTextColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _refreshResults,
            icon: Icon(Icons.refresh, color: ColorsApp.kWhiteColor),
            label: Text(
              'Try Again',
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
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
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
                CircleAvatar(
                  radius: 30,
                  backgroundColor: doctor['color'].withOpacity(0.1),
                  child: Text(
                    doctor['avatar'],
                    style: GoogleFonts.montserrat(
                      color: doctor['color'],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['name'],
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.kTextColor,
                        ),
                      ),
                      Text(
                        doctor['specialty'],
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: ColorsApp.kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        doctor['hospital'],
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: ColorsApp.kSecondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: ColorsApp.kAmberColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          doctor['rating'].toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorsApp.kTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: doctor['isAvailable'] 
                            ? ColorsApp.kSuccessColor.withOpacity(0.1)
                            : ColorsApp.kErrorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        doctor['availability'],
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: doctor['isAvailable'] 
                              ? ColorsApp.kSuccessColor
                              : ColorsApp.kErrorColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(
                  Icons.location_on,
                  doctor['distance'],
                  ColorsApp.kTealColor,
                ),
                const SizedBox(width: 12),
                _buildInfoChip(
                  Icons.work,
                  doctor['experience'],
                  ColorsApp.kPurpleColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewDoctorProfile(doctor),
                    icon: Icon(Icons.person, color: ColorsApp.kPrimaryColor),
                    label: Text(
                      'View Profile',
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
                    onPressed: doctor['isAvailable'] 
                        ? () => _bookAppointment(doctor)
                        : null,
                    icon: Icon(Icons.calendar_today, color: ColorsApp.kWhiteColor),
                    label: Text(
                      'Book Now',
                      style: GoogleFonts.montserrat(
                        color: ColorsApp.kWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: doctor['isAvailable'] 
                          ? ColorsApp.kPrimaryColor
                          : ColorsApp.kLightGreyColor,
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

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredDoctors() {
    List<Map<String, dynamic>> filtered = List.from(_nearbyDoctors);

    // Filter by specialty
    if (_selectedSpecialty != 'All') {
      filtered = filtered.where((doctor) => 
        doctor['specialty'] == _selectedSpecialty
      ).toList();
    }

    // Filter by distance (simplified)
    final maxDistance = double.parse(_selectedDistance.split(' ')[0]);
    filtered = filtered.where((doctor) {
      final distance = double.parse(doctor['distance'].split(' ')[0]);
      return distance <= maxDistance;
    }).toList();

    return filtered;
  }

  void _applyFilters() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _refreshResults() {
    setState(() {
      _isLoading = true;
    });

    // Simulate refresh
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _getCurrentLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Getting your current location...'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _viewDoctorProfile(Map<String, dynamic> doctor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing profile of ${doctor['name']}'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _bookAppointment(Map<String, dynamic> doctor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking appointment with ${doctor['name']}'),
        backgroundColor: ColorsApp.kSuccessColor,
      ),
    );
  }
}
