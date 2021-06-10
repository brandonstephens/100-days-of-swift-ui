//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Stephens on 5/20/21.
//

import LocalAuthentication
import SwiftUI
import MapKit

class UserData: ObservableObject {
    @Published var selectedPlace: MKPointAnnotation?
    @Published var centerCoordinate = CLLocationCoordinate2D()
    @Published var locations = [CodableMKPointAnnotation]()
    @Published var showingPlaceDetails = false
    @Published var showingEditScreen = false
    @Published var isUnlocked = false
    @Published var authError = ""
    @Published var showAuthError = true
}

struct ContentView: View {
    @EnvironmentObject var state: UserData
        
    var body: some View {
        ZStack {
            if state.isUnlocked {
                FullMapView()
            } else {
                if state.showAuthError {
                    Text("\(state.authError)")
                        .padding()
                }
                
                Button("Unlock") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                
            }
        }
        .alert(isPresented: $state.showingPlaceDetails) {
            Alert(
                title: Text(state.selectedPlace?.title ?? "Unknown"),
                message: Text(state.selectedPlace?.subtitle ?? "Missing info"),
                primaryButton: .default(Text("Okay")),
                secondaryButton: .default(Text("Edit")) {
                    state.showingEditScreen = true
                }
            )
        }
        .sheet(isPresented: $state.showingEditScreen, onDismiss: saveData) {
            if state.selectedPlace != nil {
                EditView(placemark: state.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            state.locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(state.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please auth to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        state.isUnlocked = true
                    } else {
                        state.authError = error?.localizedDescription ?? "Error"
                        state.showAuthError = true
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12").environmentObject(UserData())
    }
}

struct FullMapView: View {
    @EnvironmentObject var state: UserData
    
    var body: some View {
        ZStack {
            MapView(
                centerCoordinate: $state.centerCoordinate,
                selectedPlace: $state.selectedPlace,
                showingPlaceDetails: $state.showingPlaceDetails,
                annotations: state.locations
            )
            .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.title = "Example"
                        newLocation.coordinate = state.centerCoordinate
                        state.locations.append(newLocation)
                        state.selectedPlace = newLocation
                        state.showingEditScreen = true
                    }, label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    })
                    
                }
            }
        }
    }
}
