//
//  TextFieldAndAddBtnView.swift
//  GameOfLife
//
//  Created by Nikolay Raychev on 31.08.21.
//

import SwiftUI

struct TextFieldAndAddBtnView: View {
    @EnvironmentObject var matrix: MatrixManager
    var body: some View {
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
    }
}

struct TextFieldAndAddBtnView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldAndAddBtnView()
    }
}
