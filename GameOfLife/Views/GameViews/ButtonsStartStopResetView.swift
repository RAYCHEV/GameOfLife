//
//  ButtonsStartStopResetView.swift
//  GameOfLife
//
//  Created by Nikolay Raychev on 31.08.21.
//

import SwiftUI

struct ButtonsStartStopResetView: View {
    @EnvironmentObject var matrix: MatrixManager
    
    var body: some View {
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
    }
}

struct ButtonsStartStopResetView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsStartStopResetView()
    }
}
