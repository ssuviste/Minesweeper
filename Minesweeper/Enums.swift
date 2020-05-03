//
//  Difficulty.swift
//  Minesweeper
//
//  Created by Anonymous on 24.04.2020.
//  Copyright © 2020 Anonymous. All rights reserved.
//

enum Theme {
    case Light
    case Dark1
    case Dark2
}

enum Difficulty {
    case L1
    case L2
    case L3
    case Custom
}

enum GameState {
    case InProgress
    case PlayerWin
    case PlayerLose
}

enum BoardBtnState {
    case Unrevealed
    case Revealed
    case Flagged
}

enum BoardBtnContent {
    case Clear
    case Mine
}