import Foundation
import SwiftUI
import Combine


struct ContentView: View {
   @StateObject var matrix = MatrixManager()
    
    var body: some View {
        ScrollView() {
            HStack {
                Button(action: {
                    self.matrix.start()
                }, label: {
                    Text("Start")
                })
                Button(action: {
                    self.matrix.stop()
                }, label: {
                    Text("Stop")
                })
                Button(action: {
                    self.matrix.reset()
                }, label: {
                    Text("Reset")
                })
               
            }
            ScrollView(.horizontal){
                ZStack {
                    Text("\(matrix.dysplayedString)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

