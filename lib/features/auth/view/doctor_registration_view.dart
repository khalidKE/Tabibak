import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/constant/string.dart';

class DoctorRegistrationView extends StatefulWidget {
  const DoctorRegistrationView({super.key});

  @override
  State<DoctorRegistrationView> createState() => _DoctorRegistrationViewState();
}

class _DoctorRegistrationViewState extends State<DoctorRegistrationView> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isLoading = false;
  

  final _specializationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _licenseController = TextEditingController();
  
  String? _idCardImage;
  String? _professionalCardImage;
  String? _licenseImage;
  
  String? _currentLocation;
  bool _locationPermissionGranted = false;

  @override
  void dispose() {
    _pageController.dispose();
    _specializationController.dispose();
    _experienceController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _selectImage(String type) {
    setState(() {
      switch (type) {
        case 'idCard':
          _idCardImage = 'assets/images/placeholder.png';
          break;
        case 'professionalCard':
          _professionalCardImage = 'assets/images/placeholder.png';
          break;
        case 'license':
          _licenseImage = 'assets/images/placeholder.png';
          break;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$type image selected'),
        backgroundColor: ColorsApp.kSuccessColor,
      ),
    );
  }

  void _getLocation() {
    setState(() {
      _locationPermissionGranted = true;
      _currentLocation = 'Cairo, Egypt'; 
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location permission granted'),
        backgroundColor: ColorsApp.kSuccessColor,
      ),
    );
  }

  void _completeRegistration() {
    if (_idCardImage != null && _professionalCardImage != null && 
        _licenseImage != null && _currentLocation != null) {
      setState(() {
        _isLoading = true;
      });
      
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration completed successfully!'),
            backgroundColor: ColorsApp.kSuccessColor,
          ),
        );
        
        Navigator.pushNamedAndRemoveUntil(
          context, 
          Routes.home, 
          (route) => false
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all steps'),
          backgroundColor: ColorsApp.kErrorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsApp.kPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Doctor Registration',
          style: GoogleFonts.montserrat(
            color: ColorsApp.kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                    decoration: BoxDecoration(
                      color: index <= _currentStep 
                          ? ColorsApp.kPrimaryColor 
                          : ColorsApp.kLightGreyColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                _buildStepIndicator('Basic Info', 0),
                _buildStepIndicator('Documents', 1),
                _buildStepIndicator('Location', 2),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                _buildBasicInfoStep(),
                _buildDocumentsStep(),
                _buildLocationStep(),
              ],
            ),
          ),
          
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: ColorsApp.kPrimaryColor),
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          color: ColorsApp.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentStep == 2 ? _completeRegistration : _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.kPrimaryColor,
                      foregroundColor: ColorsApp.kWhiteColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(ColorsApp.kWhiteColor),
                            ),
                          )
                        : Text(
                            _currentStep == 2 ? 'Complete' : 'Next',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(String title, int step) {
    final isActive = step == _currentStep;
    final isCompleted = step < _currentStep;
    
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted 
                  ? ColorsApp.kSuccessColor 
                  : isActive 
                      ? ColorsApp.kPrimaryColor 
                      : ColorsApp.kLightGreyColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : Icons.circle,
              color: ColorsApp.kWhiteColor,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? ColorsApp.kPrimaryColor : ColorsApp.kSecondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Information',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Please provide your professional information',
            style: TextStyle(
              color: ColorsApp.kSecondaryTextColor,
              fontSize: 14,
            ),
          ),
          
          const SizedBox(height: 32),
          
          _buildInputField(
            controller: _specializationController,
            label: 'Specialization',
            hint: 'e.g., Cardiology, Neurology',
            icon: Icons.medical_services,
          ),
          
          const SizedBox(height: 20),
          
          _buildInputField(
            controller: _experienceController,
            label: 'Years of Experience',
            hint: 'e.g., 5',
            icon: Icons.work,
            keyboardType: TextInputType.number,
          ),
          
          const SizedBox(height: 20),
          
          _buildInputField(
            controller: _licenseController,
            label: 'Medical License Number',
            hint: 'Enter your license number',
            icon: Icons.badge,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Required Documents',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Please upload the following documents for verification',
            style: TextStyle(
              color: ColorsApp.kSecondaryTextColor,
              fontSize: 14,
            ),
          ),
          
          const SizedBox(height: 32),
          
          _buildDocumentUpload(
            'National ID Card',
            'Upload a clear photo of your ID card',
            _idCardImage,
            () => _selectImage('idCard'),
            Icons.credit_card,
          ),
          
          const SizedBox(height: 24),
          
          _buildDocumentUpload(
            'Professional Card',
            'Upload your medical professional card',
            _professionalCardImage,
            () => _selectImage('professionalCard'),
            Icons.work,
          ),
          
          const SizedBox(height: 24),
          
          _buildDocumentUpload(
            'Medical License',
            'Upload your medical license certificate',
            _licenseImage,
            () => _selectImage('license'),
            Icons.verified,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location Access',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorsApp.kTextColor,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'We need your location to help patients find you nearby',
            style: TextStyle(
              color: ColorsApp.kSecondaryTextColor,
              fontSize: 14,
            ),
          ),
          
          const SizedBox(height: 32),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorsApp.kWhiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.location_on,
                  size: 48,
                  color: _locationPermissionGranted 
                      ? ColorsApp.kSuccessColor 
                      : ColorsApp.kPrimaryColor,
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  _locationPermissionGranted ? 'Location Access Granted' : 'Enable Location Access',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.kTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  _locationPermissionGranted 
                      ? 'Your location: $_currentLocation'
                      : 'Allow Tabibak to access your location to help patients find you',
                  style: TextStyle(
                    color: ColorsApp.kSecondaryTextColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 20),
                
                if (!_locationPermissionGranted)
                  ElevatedButton.icon(
                    onPressed: _getLocation,
                    icon: const Icon(Icons.location_on),
                    label: const Text('Enable Location'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.kPrimaryColor,
                      foregroundColor: ColorsApp.kWhiteColor,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorsApp.kTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Container(
          decoration: BoxDecoration(
            color: ColorsApp.kWhiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: ColorsApp.kSecondaryTextColor),
              prefixIcon: Icon(icon, color: ColorsApp.kPrimaryColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentUpload(
    String title,
    String description,
    String? imagePath,
    VoidCallback onTap,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsApp.kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: ColorsApp.kPrimaryColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.kTextColor,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: ColorsApp.kSecondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          if (imagePath != null)
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: ColorsApp.kLightGreyColor,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: ColorsApp.kLightGreyColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ColorsApp.kPrimaryColor,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      size: 32,
                      color: ColorsApp.kPrimaryColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap to upload',
                      style: TextStyle(
                        color: ColorsApp.kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
}
