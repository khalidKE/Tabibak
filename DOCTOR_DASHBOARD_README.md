# Doctor Dashboard & User Mode Management

## Overview
This implementation adds a comprehensive doctor dashboard with user mode management functionality to the Tabibak medical app. When a doctor logs in, they are redirected to a specialized dashboard that shows their online/offline status and provides comprehensive medical practice management tools.

## Features

### 1. User Mode Management
- **Online/Offline Toggle**: Doctors can easily switch between online and offline modes
- **Status Indicator**: Visual indicators show current status (Active/Inactive)
- **Real-time Updates**: Status changes are reflected immediately across the app
- **Last Seen Tracking**: Shows when the doctor was last active

### 2. Doctor Dashboard
- **Welcome Section**: Personalized greeting with doctor information and status
- **Quick Stats**: Overview of appointments, patients, pending reports, and earnings
- **Quick Actions**: Easy access to common tasks (schedule, patient records, chat, etc.)
- **Recent Patients**: List of recent patient interactions
- **Today's Appointments**: Overview of scheduled appointments

### 3. Navigation
- **Dashboard**: Main overview and statistics
- **Appointments**: Detailed appointment management
- **Patients**: Patient management system
- **Schedule**: Schedule management tools

## Implementation Details

### Files Created/Modified

#### New Files:
1. **`lib/features/doctor_discovery/view/doctor_dashboard_view.dart`**
   - Main doctor dashboard interface
   - User mode toggle and status display
   - Comprehensive dashboard with multiple sections

2. **`lib/features/doctor_discovery/data/models/user_mode_model.dart`**
   - Data model for user mode information
   - Tracks online status, location, and additional info

3. **`lib/features/doctor_discovery/services/user_mode_service.dart`**
   - Service layer for managing user mode
   - Handles status updates and backend synchronization
   - Provides real-time status streaming

#### Modified Files:
1. **`lib/features/auth/view/login_view.dart`**
   - Added role selection dropdown
   - Redirects doctors to doctor dashboard
   - Redirects patients to regular home

2. **`lib/core/routing/router.dart`**
   - Added doctor dashboard route
   - Integrated with existing routing system

3. **`lib/features/auth/view/doctor_registration_view.dart`**
   - Updated to redirect to doctor dashboard after registration

### Key Components

#### User Mode Toggle
- Located in the app bar
- Shows current status (Online/Offline)
- Includes last seen information
- Real-time status updates

#### Status Indicators
- **Active**: Green color with "ACTIVE" label
- **Inactive**: Grey color with "INACTIVE" label
- **Last Seen**: Shows time since last activity

#### Quick Status FAB
- Floating action button for quick status toggle
- Changes color based on current status
- Provides easy access to status management

## Usage

### For Doctors:
1. **Login**: Select "Doctor" role and enter credentials
2. **Dashboard Access**: Automatically redirected to doctor dashboard
3. **Status Management**: Toggle online/offline mode using the switch in the app bar
4. **Quick Actions**: Use the floating action button for quick status changes

### For Patients:
1. **Login**: Select "Patient" role and enter credentials
2. **Regular Access**: Redirected to standard home view
3. **Doctor Discovery**: Can see doctor availability based on online status

## Technical Implementation

### State Management
- Uses Flutter's built-in `StatefulWidget` for local state
- `UserModeService` provides centralized status management
- Stream-based updates for real-time status changes

### Data Flow
1. Doctor logs in with role selection
2. `UserModeService` initializes doctor mode
3. Status changes are broadcast via streams
4. UI updates reflect current status
5. Backend synchronization (placeholder for real implementation)

### Responsive Design
- Adapts to different screen sizes
- Mobile-first approach with tablet/desktop optimizations
- Consistent with existing app design patterns

## Future Enhancements

### Backend Integration
- Real-time status synchronization with server
- Push notifications for status changes
- Multi-device status management

### Advanced Features
- **Availability Scheduling**: Set specific online hours
- **Auto-Status**: Automatic status based on calendar
- **Status History**: Track status changes over time
- **Patient Notifications**: Alert patients when doctor goes online

### Analytics
- Track online time and availability
- Patient interaction metrics
- Revenue impact of availability

## Dependencies
- `google_fonts`: For consistent typography
- `flutter`: Core framework
- Custom color constants and routing system

## Testing
- Test role selection in login
- Verify doctor dashboard navigation
- Test status toggle functionality
- Validate responsive design on different screen sizes

## Notes
- Current implementation uses mock data for demonstration
- Backend integration points are marked with TODO comments
- User mode service is designed for easy extension
- Follows existing app architecture patterns
