import Foundation
import SwiftUI
import Combine


struct ContentView: View {
    @StateObject var matrix = MatrixManager(rows: 6, columns: 6)
        
    var body: some View {
        VStack{
            ScrollView() {
                
                ScrollView(.horizontal){
                    ZStack {
                        Text("\(matrix.dysplayedString)")
                    }
                }
            }
            ButtonsStartStopResetView()
            
            HStack {
                TextField("format 1.1.2.2.3.3", text: $matrix.addedPoints)
                    .keyboardType(.decimalPad)
                    .border(Color.blue)
                    .frame(width: 200.0)
                    .cornerRadius(3.0)
                    .padding(.leading)
                Button(action: {
                    self.matrix.addPoints(points: matrix.addedPoints)
                }, label: {
                    Text("add points")
                })
            }
            .padding(.horizontal)

        } .environmentObject(matrix)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
