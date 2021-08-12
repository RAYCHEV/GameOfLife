import Foundation
import SwiftUI
import Combine

class MatrixManager: ObservableObject {
    
    @Published var dysplayedString: String = ""
    
    var timer = Timer()
    
    let rows: Int
    let columns: Int
    
    var matrix: Matrix<Bool>
    var matrixTemp: Matrix<Bool>
    
    init(){
        self.rows = 16
        self.columns = 16
        matrix = Matrix(rows: rows, columns: columns, defaultValue:false)
        matrixTemp = Matrix(rows: rows, columns: columns, defaultValue:false)
        matrixInit()
    }
    
    func matrixInit() {

        matrixTemp[10,10] = true
        matrixTemp[10,11] = true
        matrixTemp[10,12] = true
        
        matrixTemp[2,2] = true
        matrixTemp[3,3] = true
        matrixTemp[2,3] = true
        matrixTemp[3,2] = true
        
        matrixTemp[4,4] = true
        matrixTemp[4,5] = true
        matrixTemp[5,5] = true
        matrixTemp[5,4] = true

    }
    
    func start() {
        
     
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.dysplayedString = self.generateNewMatrixView()
        }
    }
    
    func stop() {
        
        timer.invalidate()
    }
    
    func reset() {
        
        self.matrixInit()
        timer.invalidate()
    }
    
    func generateNewMatrixView() -> String {
      
        matrix = matrixTemp
        writingOnMatrix()
        
        return readingMatrix()
    }
    
    func readingMatrix() -> String{
        var matrixAsString: String = ""
        
        for row in 0 ..< rows {
                for col in 0 ..< columns {

                    if(matrix[row,col]) {
                        matrixAsString += "🟩"
                    }else {
                        matrixAsString += "🟧"
                    }
                }
                matrixAsString += "\n"
        }
        return matrixAsString
    }
    
    func writingOnMatrix(){
                
        for row in 0 ..< rows {
                for col in 0 ..< columns {

                    //if cell is live
                    if (matrix[row, col]) {

                        matrixTemp[row, col] = condition1ForLiveCell(row: row, col: col)
                    } else {
                        
                        matrixTemp[row, col] = condition2ForDeadCell(row: row, col: col)
                    }
                }
        }
    }
    
    func isValidMatrixRange(row: Int, col: Int) -> Bool {
        
        return row >= 0 && row < rows && col >= 0 && col < columns
    }
    
    //Any live cell with two or three live neighbours survives.
    func condition1ForLiveCell(row: Int, col: Int) -> Bool {
        
        let neighbords = chekingNeighbors(row: row, col: col)
        if neighbords == 2 || neighbords == 3{
            return true
        } else {
            return false
        }
    }
    
    //Any dead cell with three live neighbours becomes a live cell.
    func condition2ForDeadCell(row: Int, col: Int) -> Bool {
        
        let neighbords = chekingNeighbors(row: row, col: col)
        if neighbords == 3{
            return true
        } else {
            return false
        }
    }
        
    //counting neighbors
    func chekingNeighbors(row: Int, col: Int) -> Int {
        
        var totalLiveNeighbors: Int = 0
        
        for rowIndex in -1 ... 1 {
            for colIndex in -1 ... 1{
                if !isValidMatrixRange(row: row + rowIndex, col: col + colIndex) {
                    continue
                }
                if rowIndex == 0 && colIndex == 0 {
                    continue
                }
                
                if matrix[row + rowIndex, col + colIndex] {
                    totalLiveNeighbors += 1
                }
            }
        }
        return totalLiveNeighbors
    }
}
