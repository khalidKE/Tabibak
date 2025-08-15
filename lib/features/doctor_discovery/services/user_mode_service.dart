import 'dart:async';
import 'package:tabibak/features/doctor_discovery/data/models/user_mode_model.dart';

class UserModeService {
  static final UserModeService _instance = UserModeService._internal();
  factory UserModeService() => _instance;
  UserModeService._internal();

  // Stream controller for user mode changes
  final StreamController<UserModeModel> _userModeController = StreamController<UserModeModel>.broadcast();
  Stream<UserModeModel> get userModeStream => _userModeController.stream;

  // Current user mode
  UserModeModel? _currentUserMode;
  UserModeModel? get currentUserMode => _currentUserMode;

  // Timer for periodic status updates
  Timer? _statusUpdateTimer;

  /// Initialize user mode for a doctor
  void initializeDoctorMode({
    required String doctorId,
    required String doctorName,
    required String specialty,
    required String location,
  }) {
    _currentUserMode = UserModeModel(
      userId: doctorId,
      userType: 'doctor',
      isOnline: true,
      lastSeen: DateTime.now(),
      currentLocation: location,
      additionalInfo: {
        'doctorName': doctorName,
        'specialty': specialty,
        'location': location,
      },
    );

    // Start periodic status updates
    _startStatusUpdates();
    
    // Notify listeners
    _userModeController.add(_currentUserMode!);
  }

  /// Toggle online/offline status
  void toggleOnlineStatus(bool isOnline) {
    if (_currentUserMode != null) {
      _currentUserMode = _currentUserMode!.copyWith(
        isOnline: isOnline,
        lastSeen: DateTime.now(),
      );
      
      // Notify listeners
      _userModeController.add(_currentUserMode!);
      
      // Update status in backend (in real app)
      _updateStatusInBackend();
    }
  }

  /// Update current location
  void updateLocation(String newLocation) {
    if (_currentUserMode != null) {
      _currentUserMode = _currentUserMode!.copyWith(
        currentLocation: newLocation,
        lastSeen: DateTime.now(),
      );
      
      // Notify listeners
      _userModeController.add(_currentUserMode!);
      
      // Update location in backend (in real app)
      _updateLocationInBackend(newLocation);
    }
  }

  /// Update additional info
  void updateAdditionalInfo(Map<String, dynamic> newInfo) {
    if (_currentUserMode != null) {
      _currentUserMode = _currentUserMode!.copyWith(
        additionalInfo: newInfo,
        lastSeen: DateTime.now(),
      );
      
      // Notify listeners
      _currentUserMode!.additionalInfo?.addAll(newInfo);
      _userModeController.add(_currentUserMode!);
    }
  }

  /// Get current status as string
  String getCurrentStatusText() {
    if (_currentUserMode == null) return 'Unknown';
    return _currentUserMode!.isOnline ? 'Online' : 'Offline';
  }

  /// Get current status color
  String getCurrentStatusColor() {
    if (_currentUserMode == null) return '#9E9E9E'; // Grey
    return _currentUserMode!.isOnline ? '#81C784' : '#9E9E9E'; // Green : Grey
  }

  /// Check if user is currently online
  bool isUserOnline() {
    return _currentUserMode?.isOnline ?? false;
  }

  /// Get last seen time
  String getLastSeenText() {
    if (_currentUserMode == null) return 'Unknown';
    
    final now = DateTime.now();
    final lastSeen = _currentUserMode!.lastSeen;
    final difference = now.difference(lastSeen);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  /// Start periodic status updates
  void _startStatusUpdates() {
    _statusUpdateTimer?.cancel();
    _statusUpdateTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (_currentUserMode != null) {
        _currentUserMode = _currentUserMode!.copyWith(
          lastSeen: DateTime.now(),
        );
        _userModeController.add(_currentUserMode!);
      }
    });
  }

  /// Update status in backend (placeholder for real implementation)
  void _updateStatusInBackend() {
    // TODO: Implement real backend update
    print('Updating status in backend: ${_currentUserMode?.toJson()}');
  }

  /// Update location in backend (placeholder for real implementation)
  void _updateLocationInBackend(String location) {
    // TODO: Implement real backend update
    print('Updating location in backend: $location');
  }

  /// Dispose resources
  void dispose() {
    _statusUpdateTimer?.cancel();
    _userModeController.close();
  }

  /// Get user mode for display
  Map<String, dynamic> getUserModeForDisplay() {
    if (_currentUserMode == null) {
      return {
        'status': 'Unknown',
        'statusColor': '#9E9E9E',
        'lastSeen': 'Unknown',
        'location': 'Unknown',
        'isOnline': false,
      };
    }

    return {
      'status': getCurrentStatusText(),
      'statusColor': getCurrentStatusColor(),
      'lastSeen': getLastSeenText(),
      'location': _currentUserMode!.currentLocation ?? 'Unknown',
      'isOnline': _currentUserMode!.isOnline,
      'doctorName': _currentUserMode!.additionalInfo?['doctorName'] ?? 'Unknown',
      'specialty': _currentUserMode!.additionalInfo?['specialty'] ?? 'Unknown',
    };
  }
}
