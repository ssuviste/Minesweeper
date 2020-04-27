//
//  Settings.swift
//  Minesweeper
//
//  Created by Anonymous on 22.04.2020.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import Foundation

struct Settings {
    static var rows: Int = C.minRows
    static var cols = C.minCols
    static var difficulty = Difficulty.L1
    static var minesCustom = C.minMinesCustom
    static var theme = Theme.Light
}
