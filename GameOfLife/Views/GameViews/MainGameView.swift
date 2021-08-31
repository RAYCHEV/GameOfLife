import Foundation
import SwiftUI
import Combine


struct MainGameView: View {
    @StateObject var matrix = MatrixManager(rows: 6, columns: 6)
        
    var body: some View {
        VStack{
            DysplayedMatrixView()
            ButtonsStartStopResetView()
            
            TextFieldAndAddBtnView()

        } .environmentObject(matrix)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView()
    }
}
