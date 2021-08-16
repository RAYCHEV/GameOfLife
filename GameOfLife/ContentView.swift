import Foundation
import SwiftUI
import Combine


struct ContentView: View {
    @StateObject var matrix = MatrixManager(rows: 64, columns: 32)
    
    var body: some View {
        ScrollView() {

            ScrollView(.horizontal){
                ZStack {
                    Text("\(matrix.dysplayedString)")
                }
            }
        }
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
        
        HStack {
            TextField("format 1.1.2.2.3.3", text: $matrix.addedPoints)
                .keyboardType(.decimalPad)
                .border(Color.blue)
                .frame(width: 200.0)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .padding(.leading)  
            Button(action: {
                self.matrix.addPoints(points: matrix.addedPoints)
            }, label: {
                Text("add points")
            })
        }
        .padding(.horizontal)
    
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

