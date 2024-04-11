# Fitness Tracker
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Flutter](https://img.shields.io/badge/Flutter-3.19.2-blue.svg)](https://flutter.dev/)

## Overview
Fitness Tracker is a Flutter application designed to track and display user health data using Google Fit integration. This application allows users to monitor their daily physical activity, including steps taken, distance traveled, duration of activities, and calories burned.

## Features

- **Google Fit Integration**: Seamlessly integrate with Google Fit to fetch and display user health data.
- **Real-time Statistics**: Provide real-time updates on steps taken, distance traveled, and calories burned.
- **Notification Alerts**: Notify users when specific step milestones are reached, motivating them to stay active.
- **User-friendly Interface**: Offer a user-friendly interface with intuitive navigation and visually appealing design.

## Screenshots
| ![Splash Screen](/screenshots/splash_screnn.jpg) | ![Home Screen](/screenshots/home.jpg) | ![Notification](/screenshots/notification.jpg) |
|:--:|:--:|:--:|
| *Splash Screen* | *Home Screen* | *Millstone Notification* |
## Getting Started

### Prerequisites

Before running the application, ensure you have the following installed:

- Flutter SDK
- Google Fit API credential with ClintID

### Installation

1. Clone the repository:

   ```sh
   git clone https://github.com/vishalbalani/fitness_tracker.git
   ```

2. Navigate to the project directory:
   
   ```sh
   cd fitness_tracker
   ```
3. Install dependencies:
   
   ```sh
   flutter pub get
   ```
4. Run Build Runner:
   
   ```sh
   dart run build_runner build
   ```

5. Run the application:
   
   ```sh
   flutter run
   ```

## Folder Structure:

```
project/
├── constants
├── model
├── providers
├── screens
├── services
├── utils
└── widgets

```

### Documentation:

[Link to Notion Documentation](https://nifty-bridge-716.notion.site/Fitness-Tracker-e79b2f35c87b4d5387d160529992eb2d?pvs=4)
