import Foundation
import SwiftUI
import Combine

class MatrixManager: ObservableObject {
    
    @Published var dysplayedString: String = ""
    @Published var addedPoints = ""
    
    //TODO:- replacing rows, columns with defaultRows, defauldColumns
    let rows: Int
    let columns: Int
        
    var timer = Timer()
    var isTimerOn: Bool = false
    
    var matrix: Matrix<Bool>
    var matrixTemp: Matrix<Bool>
    
    init(rows: Int = 16, columns: Int = 16){
        //TODO:- convert the hardcoder values to UI input
        self.rows = rows
        self.columns = columns
        matrix = Matrix(rows: rows, columns: columns, defaultValue:false)
        matrixTemp = Matrix(rows: rows, columns: columns, defaultValue:false)
    }
        
    func start() {
        
        //double running of timer is not allowed
        if isTimerOn {
            stop()
            return
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        self.dysplayedString = self.generateNewMatrixView()
        }
        isTimerOn = true
    }
    
    func stop() {
        
        timer.invalidate()
        isTimerOn = false
    }
    
    // resetting matrix with default values
    func reset() {
        matrixTemp = Matrix(rows: rows, columns: columns, defaultValue:false)
        self.dysplayedString = self.generateNewMatrixView()

    }
    
    func addPoints(points: String) {
        let pointsArr = points.split(separator: ".")
        var pointsArrValidated = [Int]()
        
        //validation and casting
        for i in 0 ..< pointsArr.count {
            if i % 2 == 0 && isValidMatrixRange(row: Int(pointsArr[i]) ?? -1, col: Int(pointsArr[i + 1]) ?? -1) {
                pointsArrValidated.append(Int(pointsArr[i]) ?? 0)
                pointsArrValidated.append(Int(pointsArr[i + 1]) ?? 0)

            }
        }
        
        for i in 0 ..< pointsArr.count {
            
            //validation martrix input index
            if i % 2 == 0 && !(i + 1 >= pointsArrValidated.count) {
                matrixTemp[pointsArrValidated[i], pointsArrValidated[i+1]] = true
                
            }
        }
        if !isTimerOn {
            start()
        }
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
