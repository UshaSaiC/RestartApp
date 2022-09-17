import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var ButtonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var ButtonOffset: CGFloat = 0
    @State private var IsAnimating: Bool = false
    @State private var ImageOffset: CGSize = .zero
    @State private var IndicatorOpacity: Double = 1.0
    @State private var TextTitle: String = "Share"
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20){
                
                // Header
                Spacer()
                VStack(spacing: 0){
                    Text(TextTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(TextTitle)
                    
                    Text("""
                Its not how much we give but
                how much love we put into giving
                """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }
                .opacity(IsAnimating ? 1 : 0)
                .offset(y: IsAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: IsAnimating)
                
                // Center
                ZStack{
                    
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: ImageOffset.width * -1)
                        .blur(radius: abs(ImageOffset.width/5))
                        .animation(.easeOut(duration: 1), value: ImageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .opacity(IsAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: IsAnimating)
                        .offset(x: ImageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(ImageOffset.width/20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(ImageOffset.width) <= 150 {
                                        ImageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            IndicatorOpacity = 0
                                            TextTitle = "Give"
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    ImageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)){
                                        IndicatorOpacity = 1
                                        TextTitle = "Share"
                                    }
                                })
                        )
                        .animation(.easeOut(duration: 1), value: ImageOffset)
                }
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(IsAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: IsAnimating)
                    .opacity(IndicatorOpacity)
                , alignment: .bottom
                )
                
                Spacer()
                
                // Footer
                ZStack{
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: ButtonOffset + 80)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: ButtonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && ButtonOffset <= ButtonWidth - 80  {
                                        ButtonOffset = gesture.translation.width
                                    }
                                })
                                .onEnded({ _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)){
                                        if ButtonOffset > ButtonWidth/2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            ButtonOffset = ButtonWidth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            ButtonOffset = 0
                                        }
                                    }
                                })
                        )
                        Spacer()
                    }
                }
                .frame(width: ButtonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(IsAnimating ? 1 : 0)
                .offset(y: IsAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: IsAnimating)
            }
        }
        .onAppear {
            IsAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
