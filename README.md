# Student Attendance App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

## Overview

The **Student Attendance App** is a mobile application developed using Flutter that allows educators to efficiently manage student attendance by scanning QR codes. Each student has a unique QR code that corresponds to their student ID. The app seamlessly integrates with Firebase to store attendance records, enabling educators to search for student information by student ID, phone number, or name to track attendance and exam records.

## Features

- **QR Code Scanning**: Quickly take attendance by scanning students' unique QR codes.
- **Student Search**: Easily search for students using their student ID, phone number, or name.
- **Attendance Tracking**: View detailed records of how many lectures each student attended and the specific dates of their attendance.
- **Exam Tracking**: Track exam attendance with details similar to lectures.
- **Firebase Integration**: All attendance and exam data is securely stored in Firebase, allowing for real-time updates and access from anywhere.
- **Multi-Platform Support**: Runs on both Android and iOS devices.

## Installation

To get started with the Student Attendance App, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/student-attendance-app.git
   cd student-attendance-app
   ```

2. **Install Dependencies**:
   Make sure you have Flutter installed. Then run:
   ```bash
   flutter pub get
   ```

3. **Set Up Firebase**:
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Add an Android and/or iOS app to your Firebase project.
   - Download the `google-services.json` (for Android) and/or `GoogleService-Info.plist` (for iOS) and place them in the appropriate directories in your Flutter project.
   - Enable Firestore and Authentication services in your Firebase project.

4. **Run the App**:
   Connect your device or start an emulator, then run:
   ```bash
   flutter run
   ```

## Usage

1. **Scanning QR Codes**:
   - Launch the app and navigate to the attendance screen.
   - Use the camera to scan the student's QR code.
   - The app will automatically register the student's attendance for the current date and time.

2. **Searching for Students**:
   - Go to the search screen.
   - Enter the student ID, phone number, or name in the search bar.
   - View the student's attendance and exam records, including dates and the number of sessions attended.

## Technologies Used

- **Flutter**: Front-end framework for building cross-platform mobile applications.
- **Firebase**: Backend as a Service (BaaS) for authentication, real-time database, and cloud storage.
  - Firestore: To store and retrieve attendance and exam data.
  - Firebase Authentication: For user authentication and management.

## App Demo

![RecordGif1](https://github.com/user-attachments/assets/2dfafced-29c6-49a0-90e7-aff6fefd9752)


## Contributing

Contributions are welcome! If you have any suggestions or find bugs, please open an issue or submit a pull request.

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature/YourFeature`).
6. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or feedback, please feel free to contact me at [Amr90.vip@gmail.com](Amr90.vip@gmail.com).

---

This project was created to help educators streamline the process of taking attendance and tracking student participation. Your contributions and feedback are greatly appreciated!
