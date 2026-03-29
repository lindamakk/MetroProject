# Stoply 🚇

Stoply is a location-based iOS app designed for the "flow state" commuter. If you're a student in Riyadh who gets way too distracted on the metro—whether you're reading, studying, or just scrolling—and you always miss your stop, this is for you. It tracks your trip in the background and pings you right before you reach your destination or a transfer station.

<img width="2875" height="1391" alt="image" src="https://github.com/user-attachments/assets/5c043ff8-61c8-40b8-be4a-0e704f1edd00" />

## ✨ Features
* **Background tracking:** You can actually leave the app and go back to whatever you were doing.
* **Transfer alerts:** Not just for the final stop. It'll nudge you when it's time to switch lines.
* **Daily routes:** Save your commute to uni so you don't have to set it up every single morning.
* **GPS fail-safe:** If you're deep underground and the signal cuts out, it'll alert you so you don't end up at the end of the line by mistake.

## 🏗 How it's built
The project is built entirely in **SwiftUI** using a clean **MVVM** architecture. We’ve kept the UI modular so components can be swapped out easily.

### 📂 Project Breakdown
* **ViewModel/**: `CurrentTripViewModel` handles live coordinates, while `SharedData` keeps the app state in sync across different screens.
* **Views/**: Main screens including `SelectStopsView` (the picker), `HomeView` (the dashboard), and `TripEndedView`.
* **Components/**: All the reusable UI bits like `StopsProgressBar`, `TripAlert`, and `MetroLineDropDown`.
* **Data/**: `DataService` handles the heavy lifting for fetching station info and managing persistence.
* **Helpers/**: Generic utilities like `JSONHelper` for data parsing and `ColorFunction` for dynamic line colors.

## 🚀 Getting it running
* **Environment:** Xcode 15.0+ and iOS 17.0+.
* **Capabilities:** You **must** enable **Location Updates** and **Background Modes** in the project settings for the tracking to work while the app is minimized.
* **Permissions:** Make sure to select **"Always Allow"** for location when prompted, otherwise, the "distraction-free" part won't work once you switch apps!

---

## 🛠 User Flows

### 1. Starting a Journey 📍
<img height="80" alt="image" src="https://github.com/user-attachments/assets/54d5aa34-9919-4d7b-89f4-41d0c93cb34f" />

Pick your start, destination, and any transfers. The `CurrentTripViewModel` calculates the proximity radius. Once you’re close, a `TripAlert` triggers a notification.

### 2. Quick-Start (Favorites) ⭐
<img height="80" alt="image" src="https://github.com/user-attachments/assets/5522175c-4c72-4b3c-96b6-e273909795f2" />

Common routes are stored in `HistoryModel`. If you're headed to the same lecture hall every Tuesday, it's a one-tap process from the HomeView.

### 3. GPS Loss Handling 📡
<img height="80" alt="image" src="https://github.com/user-attachments/assets/822ce59b-d74f-493e-9097-6344447da922" />

Metros are notorious for dead zones. If `DataService` loses a lock on your coordinates, the app sends a high-priority alert so you don't accidentally oversleep your stop while offline.

### 4. Ending a Trip 🏁
<img height="80" alt="image" src="https://github.com/user-attachments/assets/c4e7a090-6ecf-4b67-b024-a855d209c40d" />

Once you arrive (or if you change your mind), you can cancel the journey. This immediately stops the location manager to save your battery for the rest of your classes.

---

## ⏳ What's next?
* **Haptic Alerts:** Sometimes a notification sound isn't enough in a loud station. Adding "Success" or "Warning" haptic patterns would be a life-saver.
* **Live Activities:** It would be cool to see "2 stops away" directly on the Lock Screen or Dynamic Island without even unlocking the phone.
* **Apple Watch Sync:** A quick wrist-vibrate for transfers so you don't even have to take your phone out of your pocket.
