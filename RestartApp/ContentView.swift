import SwiftUI

struct ContentView: View {
    
    private let imageURL:String = "https://credo.academy/credo-academy@3x.png"
    
    var body: some View {
        
        // AsyncImage(url: URL(string: imageURL)) // This line generates image which fills the entire screen
        
        // AsyncImage(url: URL(string: imageURL), scale: 3.0) // default value of scale is 1.0, we can make image smaller by increasing value or larger by decreasing its value via this scale parameter
        
        AsyncImage(url: URL(string: imageURL)) { image in image
                .resizable()
                .scaledToFit()
        } placeholder: { // when image URL is wrong or internet is off.. instead of actual image this custom placeholder will be displayed when image is not loaded or renderd
            Image(systemName: "photo.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 128)
                .foregroundColor(.purple)
                .opacity(0.5)
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
