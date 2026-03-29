Stoply 🚇
Stoply is a location-based iOS app for the "flow state" commuter. If you're a student in Riyadh who gets way too distracted on the metro—whether you're reading, studying, or just scrolling—and you always miss your stop, this is for you. It tracks your trip in the background and pings you right before you reach your destination or a transfer station.

<img width="2875" height="1391" alt="Stoply Preview" src="https://github.com/user-attachments/assets/5c043ff8-61c8-40b8-be4a-0e704f1edd00" />

✨ Features
Background tracking: Leave the app and go back to whatever you were doing.

Transfer alerts: Not just for the final stop. It nudges you when it's time to switch lines.

Daily routes: Save your commute to uni so you don't have to set it up every morning.

GPS fail-safe: If you're deep underground and the signal cuts out, it alerts you so you don't miss your stop while offline.

🏗 How it's built
The project uses SwiftUI and a clean MVVM architecture to keep the UI modular and components reusable.

📂 Project Breakdown

ViewModel/: CurrentTripViewModel handles live coordinates; SharedData keeps the app state in sync.

Views/: Main screens like SelectStopsView, HomeView, and TripEndedView.

Components/: Reusable UI like StopsProgressBar, TripAlert, and MetroLineDropDown.

Data/: DataService handles fetching station info and persistence.

Helpers/: Utilities like JSONHelper and ColorFunction for dynamic line colors.

🚀 Getting it running
Environment: Xcode 15.0+ / iOS 17.0+.

Capabilities: You must enable Location Updates and Background Modes in project settings for background tracking.

Permissions: Select "Always Allow" for location, otherwise tracking stops when you switch apps.

🛠 User Flows
1. Starting a Journey 📍

<img height="80" alt="Start Journey" src="https://github.com/user-attachments/assets/54d5aa34-9919-4d7b-89f4-41d0c93cb34f" />

Pick your start, destination, and transfers. CurrentTripViewModel calculates the proximity radius and triggers a TripAlert when you’re close.

2. Quick-Start (Favorites) ⭐

<img height="80" alt="Favorites" src="https://github.com/user-attachments/assets/5522175c-4c72-4b3c-96b6-e273909795f2" />

Common routes are stored in HistoryModel. If you're heading to the same lecture every Tuesday, it’s a one-tap process from the HomeView.

3. GPS Loss Handling 📡

<img height="80" alt="GPS Alert" src="https://github.com/user-attachments/assets/822ce59b-d74f-493e-9097-6344447da922" />

Metros have dead zones. If DataService loses its GPS lock, the app sends a high-priority alert so you can monitor the route manually.

4. Ending a Trip 🏁

<img height="80" alt="End Trip" src="https://github.com/user-attachments/assets/c4e7a090-6ecf-4b67-b024-a855d209c40d" />

You can cancel a journey anytime to stop the location manager and save battery for the rest of your classes.

⏳ What's next?
Haptic Alerts: Stronger vibration patterns for noisy stations.

Live Activities: See "2 stops away" on the Lock Screen or Dynamic Island.

Apple Watch Sync: Haptic wrist alerts so you don't even have to pull out your phone.
