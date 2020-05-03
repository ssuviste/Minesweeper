//
//  GameEngine.swift
//  Minesweeper
//
//  Created by Anonymous on 01.05.2020.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import Foundation

class GameEngine {
    
    private var minesCount: Int
    private var gameBoard: [[(BoardBtnState, BoardBtnContent)]]
    var gameState: GameState = GameState.InProgress
    var minesRemaining: Int
    
    init() {
        switch Settings.difficulty {
        case Difficulty.L1: minesCount = Int(Double(Settings.rows) * Double(Settings.cols) * Double(C.minesL1) / 100)
        case Difficulty.L2: minesCount = Int(Double(Settings.rows) * Double(Settings.cols) * Double(C.minesL2) / 100)
        case Difficulty.L3: minesCount = Int(Double(Settings.rows) * Double(Settings.cols) * Double(C.minesL3) / 100)
        case Difficulty.Custom: minesCount = Int(Double(Settings.rows) * Double(Settings.cols) * Double(Settings.minesCustom) / 100)
        }
        minesRemaining = minesCount
        
        gameBoard = Array(repeating: Array(repeating: (BoardBtnState.Unrevealed, BoardBtnContent.Clear), count: Settings.cols), count: Settings.rows)
        var minesToAdd = minesCount
        while minesToAdd > 0 {
            let row = Int.random(in: 0..<Settings.rows)
            let col = Int.random(in: 0..<Settings.cols)
            let (_, content) = gameBoard[row][col]
            if (content == BoardBtnContent.Clear) {
                gameBoard[row][col] = (BoardBtnState.Unrevealed, BoardBtnContent.Mine)
                minesToAdd -= 1
            }
        }
    }
    
    private func setBoardBtnState(tag: Int, state: BoardBtnState) {
        let (row, col) = convertTagToCoords(tag: tag)
        let (_, oldContent) = gameBoard[row][col]
        gameBoard[row][col] = (state, oldContent)
    }
    
    private func getAllNeighboursCoords(tag: Int) -> [(row: Int, col: Int)] {
        let (row, col) = convertTagToCoords(tag: tag)
        var result = [(Int, Int)]()
        for i in -1...1 {
            for j in -1...1 {
                if (i == 0 && j == 0) || row + i < 0 || row + i >= getRowCount() || col + j < 0 || col + j >= getColCount() {
                    continue
                } else {
                    result.append((row + i, col + j))
                }
            }
        }
        return result
    }
    
    private func convertTagToCoords(tag: Int) -> (row: Int, col: Int) {
        let row = tag / getColCount()
        let col = tag % getColCount()
        return (row, col)
    }
    
    private func convertCoordsToTag(row: Int, col: Int) -> Int {
        return row * getColCount() + col
    }
    
    private func updateMinesRemaining() {
        var flagCount = 0
        for row in gameBoard {
            for (state, _) in row {
                if state == BoardBtnState.Flagged {
                    flagCount += 1
                }
            }
        }
        minesRemaining = minesCount - flagCount
    }
    
    private func checkForGameOver() {
        var unrevealedCells = 0
        for row in gameBoard {
            for (state, content) in row {
                if state == BoardBtnState.Revealed && content == BoardBtnContent.Mine {
                    gameState = GameState.PlayerLose
                    return
                } else if state == BoardBtnState.Unrevealed {
                    unrevealedCells += 1
                }
            }
        }
        if unrevealedCells == 0 && minesRemaining == 0 {
            gameState = GameState.PlayerWin
        }
    }
    
    func getAdjMinesCount(tag: Int) -> Int {
        let neighbours = getAllNeighboursCoords(tag: tag)
        var count = 0
        for (row, col) in neighbours {
            let (_, neighbourContent) = gameBoard[row][col]
            if neighbourContent == BoardBtnContent.Mine {
                count += 1
            }
        }
        return count
    }
    
    func reveal(tag: Int) {
        setBoardBtnState(tag: tag, state: BoardBtnState.Revealed)
        checkForGameOver()
        if gameState == GameState.InProgress {
            let (_, content) = getBoardBtnValue(tag: tag)
            if getAdjMinesCount(tag: tag) == 0 && content != BoardBtnContent.Mine {
                let neighbours = getAllNeighboursCoords(tag: tag)
                for (row, col) in neighbours {
                    let (neighbourState, _) = gameBoard[row][col]
                    if neighbourState == BoardBtnState.Unrevealed {
                        let neighbourTag = convertCoordsToTag(row: row, col: col)
                        reveal(tag: neighbourTag)
                    }
                }
            }
        }
    }
    
    func flagOrUnflag(tag: Int) {
        let (state, _) = getBoardBtnValue(tag: tag)
        switch state {
        case BoardBtnState.Revealed:
            return
        case BoardBtnState.Unrevealed:
            setBoardBtnState(tag: tag, state: BoardBtnState.Flagged)
        case BoardBtnState.Flagged:
            setBoardBtnState(tag: tag, state: BoardBtnState.Unrevealed)
        }
        updateMinesRemaining()
        checkForGameOver()
    }
    
    func getRowCount() -> Int {
        return gameBoard.count
    }
    
    func getColCount() -> Int {
        return gameBoard[0].count
    }
    
    func getBoardBtnValue(tag: Int) -> (state: BoardBtnState, content: BoardBtnContent) {
        let (row, col) = convertTagToCoords(tag: tag)
        return gameBoard[row][col]
    }
    
}
