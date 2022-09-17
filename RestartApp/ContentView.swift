import SwiftUI

// added an Image extention that can be used by image views
extension Image{
    func imageModifier() -> some View{
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View{
        self
            .imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    
    private let imageURL:String = "https://credo.academy/credo-academy@3x.pn"
    
    var body: some View {
        
        //        AsyncImage(url: URL(string: imageURL)) { image in
        //            image
        //                .imageModifier()
        //        } placeholder: {
        //            Image(systemName: "photo.circle.fill")
        //                .iconModifier()
        //        }
        //        .padding(40) // as this value increases the image gets shrinked and shrinked on screen
        //    }
        
        
        AsyncImage(url: URL(string: imageURL)){
            phase in // phase gives current information of same
            // SUCCESS : image is successfully loaded
            // FAILURE : image load failed with an error
            // EMPTY : No image is loaded
            if let image = phase.image{ // success stage
                image.imageModifier()
            } else if phase.error != nil{
                Image(systemName: "ant.circle.fill").iconModifier() //failure state i.e when we send wrong url
            }else {
                Image(systemName: "photo.circle.fill").iconModifier() // empty state.. like at start when image is gonna be displayed on UI
            }
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
