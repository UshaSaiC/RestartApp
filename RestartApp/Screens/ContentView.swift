import SwiftUI

// This SwiftUI file is the central hub of our application

// Depending on its current state it would show the home screen or onboarding screen

struct ContentView: View {
    
    // AppStorage is a special SwiftUI property wrapper that uses user defaults (local storage). Its used in storing some value on deveices permanent storage by utilizing a get and set method
    // "onboarding" refers to user defaults key which should be uniquely identifiable. Later on we can use the same key to get its corresponcing value and get some stats or do operation on it
    // isOnboardingViewActive --> property name
    // true --> value of property. This value would be added only if there isn't an identical key/property in user default storage. Else it would take the default hardcoded value (in this case its true) because of AppStorage
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack{
            if isOnboardingViewActive{
                OnboardingView()
            } else {
                HomeView()
            }
        }
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
