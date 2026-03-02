//
//  CurrentTripViewModel.swift
//  MetroProject
//
//  Created by nouransalah on 23/08/1447 AH.
//

import Foundation
import Combine
import CoreLocation
import UserNotifications

class CurrentTripViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    
    // MARK: - Published Properties
    @Published var isTrackingActive: Bool = false
    @Published var currentStationIndex: Int = 0
    @Published var hasReachedDestination: Bool = false
    @Published var mapIsPassed: [MetroStation: Bool] = [:]
    // MARK: - computed properties i need to pass it to view

    //The final destination station (last station in the route)
//    var destinationStation: MetroStation? {
//        guard !sharedData.items.isEmpty else { return nil }
//        return sharedData.items.last
//    }

    var nextStation: MetroStation? {
        let nextIndex = currentStationIndex
        guard nextIndex < sharedData.items.count else { return nil }
        return sharedData.items[nextIndex]
    }
    var nextStationName: String {
        return nextStation?.nameEn ?? "Unknown Destination"
    }
    var nextStationLine: String {
        return nextStation?.lineName ?? "Unknown Destination"
    }
    //Destination station name for display
//    var destinationName: String {
//        destinationStation?.nameEn ?? "Unknown Destination"
//    }
    //Number of stations remaining (not yet passed)
    var stationsRemaining: Int {
        let remaining = sharedData.items.count - currentStationIndex
        return max(0, remaining) // Ensure we never return negative
    }
//    var destinationLineName: String {
//        destinationStation?.lineName ?? "Unknown"
//        }
    // MARK: - Private Properties
    private let sharedData = SharedData.shared
    private let locationManager = CLLocationManager()
    // MARK: - Read-only Proxies
    var itemsCount: Int { sharedData.items.count }
    
    private var lastLocationUpdate: Date?
    private let updateInterval: TimeInterval = 2.0 // 5 seconds
    private let notifyDistance: CLLocationDistance = 20
    
    
  
    // MARK: - Init
    override init() {
        super.init()
        setupPassedMap()
        UNUserNotificationCenter.current().delegate = self
        print("🟢 ViewModel initialized")
        print("🟢 Total stations: \(sharedData.items.count)")
        for (index, station) in sharedData.items.enumerated() {
            print("   Station \(index): \(station.nameEn) at (\(station.lat), \(station.lon))")
        }
    }
    // MARK: - Public Methods
    func startTrip() {
        print("\n🚀 START TRIP CALLED")
        requestNotificationPermission()
        setupLocation()
        isTrackingActive = true
        sendTripStartedNotification()
        
        print("✅ Trip started - tracking is active")
        print("🎯 Currently tracking station \(currentStationIndex): \(sharedData.items[currentStationIndex].nameEn)")
        
    }
    
    func stopTrip() {
        print("\n🛑 STOP TRIP CALLED")
        locationManager.stopUpdatingLocation()
        isTrackingActive = false
        print("✅ Trip stopped - tracking is inactive")
    }
    
    // MARK: - Setup
    private func setupLocation() {
        print("\n📍 Setting up location services...")
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // GIRLLLLLLLLLLLLLLLLLLLLLLLLLLLLS🌱 🌱💅🏻 🌱 🌱💅🏻
        locationManager.distanceFilter = 0.1
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = true
        
        handleLocationAuthorization()
        locationManager.startUpdatingLocation()
        print("✅ Location tracking started")
    }
    
    private func setupPassedMap() {
        mapIsPassed = Dictionary(
            uniqueKeysWithValues: sharedData.items.map { ($0, false) }
        )
        print("🗺️ Passed map initialized with \(mapIsPassed.count) stations")
    }
    
    private func requestNotificationPermission() {
        print("\n🔔 Requesting notification permission...")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification permission granted")
            } else {
                print("❌ Notification permission denied")
            }
            
            if let error = error {
                print("❌ Error requesting notification permission: \(error)")
            }
        }
    }
    
    // MARK: - Location Authorization
    private func handleLocationAuthorization() {
        let status = locationManager.authorizationStatus
        print("📍 Authorization Status: \(statusDescription(for: status))")
        
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    private func statusDescription(for status: CLAuthorizationStatus) -> String {
        switch status {
        case .notDetermined: return "Not Determined"
        case .restricted: return "Restricted ❌"
        case .denied: return "Denied ❌"
        case .authorizedAlways: return "Authorized Always ✅"
        case .authorizedWhenInUse: return "Authorized When In Use ✅"
        @unknown default: return "Unknown ⚠️"
        }
    }
    
    // MARK: - Location Handling
    private func handleUserLocation(_ userLocation: CLLocation) {
        print("\n🔄 HANDLING USER LOCATION")
        
        if hasReachedFinalDestination() {
            DispatchQueue.main.async {
                self.hasReachedDestination = true // 👈
                print("🏁 Reached final destination!")

            }
            //print("🏁 Reached final destination!")
            //hasReachedDestination = true
            return
        }
        
        let station = sharedData.items[currentStationIndex]
        print("🎯 Target Station [\(currentStationIndex)]: \(station.nameEn)")
        print("   📍 Station Location: (\(station.lat), \(station.lon))")
        
        let distanceToNextStation = calculateDistanceToNextStation(from: userLocation)
        print("📏 Distance to station: \(String(format: "%.2f", distanceToNextStation))m")
        print("🎯 Notify threshold: \(notifyDistance)m")
        
        if distanceToNextStation <= notifyDistance {
            print("✅ USER IS WITHIN RANGE!")
            checkIfNearStation(distance: distanceToNextStation)
        } else {
            print("⏳ Still too far from station")
        }
    }
    
    private func hasReachedFinalDestination() -> Bool {
        let reached = currentStationIndex >= sharedData.items.count
        if reached {
            print("🏁 Final destination check: YES (index \(currentStationIndex) >= \(sharedData.items.count))")
        }
        return reached
    }
    
    private func calculateDistanceToNextStation(from userLocation: CLLocation) -> CLLocationDistance {
        let station = sharedData.items[currentStationIndex]
        let stationLocation = CLLocation(
            latitude: station.lat,
            longitude: station.lon
        )
        return userLocation.distance(from: stationLocation)
    }
    
    private func checkIfNearStation(distance: CLLocationDistance) {
        print("\n🚨 STATION PROXIMITY TRIGGERED!")
        print("   Distance: \(String(format: "%.2f", distance))m")
        
        let station = sharedData.items[currentStationIndex]
        print("   Station: \(station.nameEn)")
        
        markStationAsPassed(station)
        notifyUser(for: station)
        moveToNextStation()
    }
    
    private func markStationAsPassed(_ station: MetroStation) {
        //mapIsPassed[station] = true
        DispatchQueue.main.async {
            self.mapIsPassed[station] = true // 👈
        }
        print("✅ Marked station as PASSED: \(station.nameEn)")
    }
    private func moveToNextStation() {
        let previousIndex = currentStationIndex
        //so ui render
        DispatchQueue.main.async {
            self.currentStationIndex += 1
            
            print("➡️ Moving from station \(previousIndex) to \(self.currentStationIndex)")
            
            if self.hasReachedFinalDestination() {
                print("🏁 This was the final station!")
                self.hasReachedDestination = true
            } else {
                print("🎯 Next target: \(self.sharedData.items[self.currentStationIndex].nameEn)")
            }
        }
    }
//    private func moveToNextStation() {
//        let previousIndex = currentStationIndex
//        currentStationIndex += 1
//        
//        print("➡️ Moving from station \(previousIndex) to \(currentStationIndex)")
//        
//        if hasReachedFinalDestination() {
//            print("🏁 This was the final station!")
//            hasReachedDestination = true
//        } else {
//            print("🎯 Next target: \(sharedData.items[currentStationIndex].nameEn)")
//        }
//    }
    
    // MARK: - Notifications
    private func notifyUser(for station: MetroStation) {
        print("\n🔔 SENDING NOTIFICATION for: \(station.nameEn)")
        
        let content = createNotificationContent(for: station)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        
        sendNotification(request)
    }
    
    private func createNotificationContent(for station: MetroStation) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "تنبيه محطة"
        content.body = "اقتربت من محطة \(station.nameEn)"
        content.sound = .default
        return content
    }
    
    private func sendNotification(_ request: UNNotificationRequest) {
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to send notification: \(error)")
            } else {
                print("✅ Notification sent successfully!")
                print("   ID: \(request.identifier)")
                print("   Title: \(request.content.title)")
                print("   Body: \(request.content.body)")
            }
        }
    }
    
    private func sendTripStartedNotification() {
        print("\n🔔 SENDING TRIP STARTED NOTIFICATION")
        
        guard !sharedData.items.isEmpty else {
            print("⚠️ No stations to track")
            return
        }
        
        let firstStation = sharedData.items[currentStationIndex]
        
        let content = UNMutableNotificationContent()
        content.title = "🚇 بدأت الرحلة"
        content.body = "نتتبع موقعك الآن. المحطة التالية: \(firstStation.nameEn)"
        content.sound = .default
        content.badge = 1
        
        let identifier = "trip-started-\(UUID().uuidString)"
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to send trip started notification: \(error)")
            } else {
                print("✅ Trip started notification sent!")
                print("   Title: \(content.title)")
                print("   Body: \(content.body)")
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        // Throttle updates to every 5 seconds
        if let lastUpdate = lastLocationUpdate,
           Date().timeIntervalSince(lastUpdate) < updateInterval {
            return
        }
        
        lastLocationUpdate = Date()
        
        // Your existing code...
        print("\n" + String(repeating: "=", count: 60))
        print("📍 LOCATION UPDATE")
        
        //FOR METER
//        guard let userLocation = locations.last else {
//            print("⚠️ No location in update")
//            return
//        }
//
//        print("\n" + String(repeating: "=", count: 60))
//        print("📍 LOCATION UPDATE")
        print(String(repeating: "=", count: 60))
        print("   Latitude: \(userLocation.coordinate.latitude)")
        print("   Longitude: \(userLocation.coordinate.longitude)")
        print("   Accuracy: \(userLocation.horizontalAccuracy)m")
        print("   Timestamp: \(userLocation.timestamp)")
        print("   Tracking Active: \(isTrackingActive)")
        print(String(repeating: "=", count: 60))
        
        handleUserLocation(userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Location Manager Error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("\n🔐 Authorization Status Changed: \(statusDescription(for: status))")
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("🔔 Notification will present while app is active")
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("🔔 User tapped on notification: \(response.notification.request.identifier)")
        completionHandler()
    }
}//class
//
//class CurrentTripViewModel: NSObject, ObservableObject {
//
//    @Published var isTrackingActive: Bool = false
//
//    // MARK: - Shared Data
//    private let sharedData = SharedData.shared
//
//    // MARK: - Published Properties
//    @Published var currentStationIndex: Int = 0
//    @Published var hasReachedDestination: Bool = false
//    @Published var mapIsPassed: [MetroStationTEST: Bool] = [:]
//
//    // MARK: - Location
//    private let locationManager = CLLocationManager()
//    private let notifyDistance: CLLocationDistance = 1.5 // Changed back to 250 for testing
//
//    // MARK: - Init
//    override init() {
//        super.init()
//        setupPassedMap()
//
//        // ✅ ADD THIS: Set notification delegate
//        UNUserNotificationCenter.current().delegate = self
//
//        print("🟢 ViewModel initialized")
//        print("🟢 Total stations: \(sharedData.items.count)")
//        for (index, station) in sharedData.items.enumerated() {
//            print("   Station \(index): \(station.name) at (\(station.latitude), \(station.longitude))")
//        }
//    }
//
//    // MARK: - Public Methods
//    func startTrip() {
//        print("\n🚀 START TRIP CALLED")
//        requestNotificationPermission()
//        setupLocation()
//        isTrackingActive = true
//
//
//        // ✅ ADD THIS: Send immediate notification when trip starts
//        sendTripStartedNotification()
//
//
//        print("✅ Trip started - tracking is active")
//        print("🎯 Currently tracking station \(currentStationIndex): \(sharedData.items[currentStationIndex].name)")
//    }
//
//    func stopTrip() {
//        print("\n🛑 STOP TRIP CALLED")
//        locationManager.stopUpdatingLocation()
//        isTrackingActive = false
//        print("✅ Trip stopped - tracking is inactive")
//    }
//
//    // MARK: - Notification Permission
//    private func requestNotificationPermission() {
//        print("\n🔔 Requesting notification permission...")
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if granted {
//                print("✅ Notification permission granted")
//            } else {
//                print("❌ Notification permission denied")
//            }
//
//            if let error = error {
//                print("❌ Error requesting notification permission: \(error)")
//            }
//        }
//    }
//
//    // MARK: - Setup
//    private func setupLocation() {
//        print("\n📍 Setting up location services...")
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = 0.1 // Update every 10 meters
//        // ✅ ADD THESE LINES FOR BACKGROUND UPDATES
//           locationManager.allowsBackgroundLocationUpdates = true
//           locationManager.pausesLocationUpdatesAutomatically = false
//           locationManager.showsBackgroundLocationIndicator = true // Optional: shows blue bar
//
//
//
//        // Check authorization status
//        let status = locationManager.authorizationStatus
//        print("📍 Authorization Status: \(status.rawValue)")
//
//        switch status {
//        case .notDetermined:
//            // ✅ CHANGE THIS LINE to request "Always" permission for better background support
//                    locationManager.requestAlwaysAuthorization() // Instead of requestWhenInUseAuthorization()
//        case .restricted:
//            print("❌ Status: Restricted")
//        case .denied:
//            print("❌ Status: Denied")
//        case .authorizedAlways:
//            print("✅ Status: Authorized Always")
//        case .authorizedWhenInUse:
//            print("✅ Status: Authorized When In Use")
//        @unknown default:
//            print("⚠️ Status: Unknown")
//        }
//
//        locationManager.startUpdatingLocation()
//        print("✅ Location tracking started")
//    }
//
//    private func setupPassedMap() {
//        mapIsPassed = Dictionary(
//            uniqueKeysWithValues: sharedData.items.map { ($0, false) }
//        )
//        print("🗺️ Passed map initialized with \(mapIsPassed.count) stations")
//    }
//
//    // MARK: - Core Logic
//    private func handleUserLocation(_ userLocation: CLLocation) {
//        print("\n🔄 HANDLING USER LOCATION")
//
//        // 1️⃣ Check if reached final destination
//        if hasReachedFinalDestination() {
//            print("🏁 Reached final destination!")
//            hasReachedDestination = true
//            return
//        }
//
//        // Get current target station
//        let station = sharedData.items[currentStationIndex]
//        print("🎯 Target Station [\(currentStationIndex)]: \(station.name)")
//        print("   📍 Station Location: (\(station.latitude), \(station.longitude))")
//
//        // 2️⃣ Calculate distance to next station
//        let distanceToNextStation = calculateDistanceToNextStation(from: userLocation)
//        print("📏 Distance to station: \(String(format: "%.2f", distanceToNextStation))m")
//        print("🎯 Notify threshold: \(notifyDistance)m")
//
//        // 3️⃣ Check if user is near the station
//        if distanceToNextStation <= notifyDistance {
//            print("✅ USER IS WITHIN RANGE!")
//            checkIfNearStation(distance: distanceToNextStation)
//        } else {
//            print("⏳ Still too far from station")
//        }
//    }
//
//    // MARK: - Step 1: Check Final Destination
//    private func hasReachedFinalDestination() -> Bool {
//        let reached = currentStationIndex >= sharedData.items.count
//        if reached {
//            print("🏁 Final destination check: YES (index \(currentStationIndex) >= \(sharedData.items.count))")
//        }
//        return reached
//    }
//
//    // MARK: - Step 2: Calculate Distance
//    private func calculateDistanceToNextStation(from userLocation: CLLocation) -> CLLocationDistance {
//        let station = sharedData.items[currentStationIndex]
//        let stationLocation = CLLocation(
//            latitude: station.latitude,
//            longitude: station.longitude
//        )
//        let distance = userLocation.distance(from: stationLocation)
//        return distance
//    }
//
//    // MARK: - Step 3: Check Proximity & Handle
//    private func checkIfNearStation(distance: CLLocationDistance) {
//        print("\n🚨 STATION PROXIMITY TRIGGERED!")
//        print("   Distance: \(String(format: "%.2f", distance))m")
//
//        let station = sharedData.items[currentStationIndex]
//        print("   Station: \(station.name)")
//
//        // Mark as passed
//        markStationAsPassed(station)
//
//        // Send notification
//        notifyUser(for: station)
//
//        // Move to next station
//        moveToNextStation()
//    }
//
//    // MARK: - Helpers
//    private func markStationAsPassed(_ station: MetroStationTEST) {
//        mapIsPassed[station] = true
//        print("✅ Marked station as PASSED: \(station.name)")
//    }
//
//    private func moveToNextStation() {
//        let previousIndex = currentStationIndex
//        currentStationIndex += 1
//
//        print("➡️ Moving from station \(previousIndex) to \(currentStationIndex)")
//
//        if hasReachedFinalDestination() {
//            print("🏁 This was the final station!")
//            hasReachedDestination = true
//        } else {
//            print("🎯 Next target: \(sharedData.items[currentStationIndex].name)")
//        }
//    }
//
//    private func notifyUser(for station: MetroStationTEST) {
//        print("\n🔔 SENDING NOTIFICATION for: \(station.name)")
//
//        let content = UNMutableNotificationContent()
//        content.title = "تنبيه محطة"
//        content.body = "اقتربت من محطة \(station.name)"
//        content.sound = .default
//
//        let identifier = UUID().uuidString
//        let request = UNNotificationRequest(
//            identifier: identifier,
//            content: content,
//            trigger: nil // Immediate notification
//        )
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("❌ Failed to send notification: \(error)")
//            } else {
//                print("✅ Notification sent successfully!")
//                print("   ID: \(identifier)")
//                print("   Title: \(content.title)")
//                print("   Body: \(content.body)")
//            }
//        }
//    }
//}
//
//// MARK: - CLLocationManagerDelegate
//extension CurrentTripViewModel: CLLocationManagerDelegate {
//
//    func locationManager(
//        _ manager: CLLocationManager,
//        didUpdateLocations locations: [CLLocation]
//    ) {
//        guard let userLocation = locations.last else {
//            print("⚠️ No location in update")
//            return
//        }
//
//        print("\n" + String(repeating: "=", count: 60))
//        print("📍 LOCATION UPDATE")
//        print(String(repeating: "=", count: 60))
//        print("   Latitude: \(userLocation.coordinate.latitude)")
//        print("   Longitude: \(userLocation.coordinate.longitude)")
//        print("   Accuracy: \(userLocation.horizontalAccuracy)m")
//        print("   Timestamp: \(userLocation.timestamp)")
//        print("   Tracking Active: \(isTrackingActive)")
//        print(String(repeating: "=", count: 60))
//
//        handleUserLocation(userLocation)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("❌ Location Manager Error: \(error.localizedDescription)")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print("\n🔐 Authorization Status Changed:")
//        switch status {
//        case .notDetermined:
//            print("   Not Determined")
//        case .restricted:
//            print("   ❌ Restricted")
//        case .denied:
//            print("   ❌ Denied")
//        case .authorizedAlways:
//            print("   ✅ Authorized Always")
//        case .authorizedWhenInUse:
//            print("   ✅ Authorized When In Use")
//        @unknown default:
//            print("   ⚠️ Unknown")
//        }
//    }
//
//    private func sendTripStartedNotification() {
//        print("\n🔔 SENDING TRIP STARTED NOTIFICATION")
//
//        guard !sharedData.items.isEmpty else {
//            print("⚠️ No stations to track")
//            return
//        }
//
//        let firstStation = sharedData.items[currentStationIndex]
//
//        let content = UNMutableNotificationContent()
//        content.title = "🚇 بدأت الرحلة"
//        content.body = "نتتبع موقعك الآن. المحطة التالية: \(firstStation.name)"
//        content.sound = .default
//        content.badge = 1 // Optional: show badge on app icon
//
//        let identifier = "trip-started-\(UUID().uuidString)"
//        let request = UNNotificationRequest(
//            identifier: identifier,
//            content: content,
//            trigger: nil
//        )
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("❌ Failed to send trip started notification: \(error)")
//            } else {
//                print("✅ Trip started notification sent!")
//                print("   Title: \(content.title)")
//                print("   Body: \(content.body)")
//            }
//        }
//    }
//}
//
//
//// MARK: - UNUserNotificationCenterDelegate
//extension CurrentTripViewModel: UNUserNotificationCenterDelegate {
//
//    // ✅ This makes notifications appear even when app is in foreground
//    func userNotificationCenter(
//        _ center: UNUserNotificationCenter,
//        willPresent notification: UNNotification,
//        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
//    ) {
//        print("🔔 Notification will present while app is active")
//
//        // Show banner, play sound, and update badge even when app is open
//        completionHandler([.banner, .sound, .badge])
//    }
//
//    // ✅ Handle when user taps on notification
//    func userNotificationCenter(
//        _ center: UNUserNotificationCenter,
//        didReceive response: UNNotificationResponse,
//        withCompletionHandler completionHandler: @escaping () -> Void
//    ) {
//        print("🔔 User tapped on notification: \(response.notification.request.identifier)")
//        completionHandler()
//    }
//}
