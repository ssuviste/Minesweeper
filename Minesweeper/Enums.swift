enum Theme {
    case T1
    case T2
    case T3
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
