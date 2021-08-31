//
//  DysplayedMatrixView.swift
//  GameOfLife
//
//  Created by Nikolay Raychev on 31.08.21.
//

import SwiftUI

struct DysplayedMatrixView: View {
    
    @EnvironmentObject var matrix: MatrixManager
    
    var body: some View {
        ScrollView() {
            
            ScrollView(.horizontal){
                ZStack {
                    Text("\(matrix.dysplayedString)")
                }
            }
        }
    }
}

struct DysplayedMatrixView_Previews: PreviewProvider {
    static var previews: some View {
        DysplayedMatrixView()
    }
}
