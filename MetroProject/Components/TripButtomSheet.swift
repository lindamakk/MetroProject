//
//  TripButtomSheet.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//
import SwiftUI



import SwiftUI

struct ContentView: View {
    
    @State private var isSheetOpen = true
    @State private var bottomSheetHeight: CGFloat = 0
    private var maxHeightBottomSheet = (UIScreen.main.bounds.height * 0.8)
    
    
    var body: some View {
        

        Color.clear
        .sheet(isPresented: $isSheetOpen, content: {
            BottomSheet(height: $bottomSheetHeight)
                .presentationDetents([.height(min(bottomSheetHeight, maxHeightBottomSheet))])
                .shadow(color: .black, radius: 5)
        })
        .ignoresSafeArea(.all)
    }
}


struct BottomSheet: View {
    
    @Binding var height: CGFloat
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                
                // Handle bar
                Rectangle()
                    .frame(width: 100, height: 6)
                    .cornerRadius(3.0)
                    .foregroundColor(Color.gray)
                    .padding(.top, 10)
                
                Rectangle()
                    .frame(height:  20)
                    .foregroundColor(.clear)
                VStack(alignment: .leading ){
                    SelectedStopCard()
                        .padding()
                    // 1 Default green button
                    ActionButton(label: "Start Trip") {
                        print("Started")
                    }
                    
                }//v
                
                Rectangle()
                    .frame(height:  250)
                    .foregroundColor(.clear)
            }
         
            .readSize { calculatedHeight in
                height = calculatedHeight.height
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


//
//struct TripButtomSheet: View {
//    @State private var isPresented: Bool = true  // Shows immediately
//
//    var body: some View {
//        Color.clear  // Invisible view
//            .sheet(isPresented: $isPresented) {
//                ContentTripButtomSheet()
//                    .presentationDetents([.medium, .height(208)])
//                    .presentationDragIndicator(.visible)
//            }
//
//    }
//}
//#Preview {
//
//
//    TripButtomSheet()
//
//}
//
struct ContentTripButtomSheet : View{
    var body: some View {
        
        VStack(alignment: .leading ){
            SelectedStopCard()
                .padding()
            // 1 Default green button
            ActionButton(label: "Start Trip") {
                print("Started")
            }
            
        }//v
        
       // .frame(maxHeight: .infinity, alignment: .top)
    }
}
