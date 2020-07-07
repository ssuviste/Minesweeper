import UIKit

class GameViewController: UIViewController {
    
    private lazy var gameEngine: GameEngine = GameEngine()
    
    private lazy var timer = Timer()
    private var time = 0
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var gameInfoLabels: [UILabel]!
    @IBOutlet weak var gameStateLabel: UILabel!
    @IBOutlet weak var minesLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var gameBoard: UIStackView!
    
    @IBAction func resetButtonTouchUpInside(_ sender: UIButton) {
        timer.invalidate()
        time = 0
        timerLabel.text = "00:00"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.timerFunc), userInfo: nil, repeats: true)
        gameEngine = GameEngine()
        updateGameInfoUI()
        updateBoardUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGameUITheme()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.timerFunc), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        updateGameInfoUI()
        initGameboardButtons()
    }
    
    @objc func timerFunc() {
        time += 1
        let minutes = time / 60
        let seconds = time % 60
        var minutesStr = "\(minutes)"
        var secondsStr = "\(seconds)"
        if minutes < 10 {
            minutesStr = "0\(minutesStr)"
        }
        if seconds < 10 {
            secondsStr = "0\(secondsStr)"
        }
        if minutes == 99 && seconds == 59 {
            timer.invalidate()
        }
        timerLabel.text = "\(minutesStr):\(secondsStr)"
    }
    
    private func updateGameUITheme() {
        switch Settings.theme {
        case Theme.Light:
            backgroundView.backgroundColor = C.themeLBgColor
            for label in gameInfoLabels {
                label.textColor = C.themeLLabelTextColor
            }
            resetButton.setTitleColor(C.themeLBtnTextColor, for: .normal)
        case Theme.Dark1:
            backgroundView.backgroundColor = C.themeD1BgColor
            for label in gameInfoLabels {
                label.textColor = C.themeD1LabelTextColor
            }
            resetButton.setTitleColor(C.themeD1BtnTextColor, for: .normal)
        case Theme.Dark2:
            backgroundView.backgroundColor = C.themeD2BgColor
            for label in gameInfoLabels {
                label.textColor = C.themeD2LabelTextColor
            }
            resetButton.setTitleColor(C.themeD2BtnTextColor, for: .normal)
        }
    }
    
    private func initGameboardButtons() {
        var btnTagCounter = 0
        for _ in 0..<gameEngine.getRowCount() {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.alignment = .fill
            rowStack.distribution = .fillEqually
            rowStack.spacing = 8.0
            gameBoard.addArrangedSubview(rowStack)
        }
        for subView in gameBoard.arrangedSubviews {
            if let rowStack = subView as? UIStackView {
                for _ in 0..<gameEngine.getColCount() {
                    let btn = UIBoardButton()
                    btn.tag = btnTagCounter
                    btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GameViewController.handleTap(gesture:))))
                    btn.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(GameViewController.handleLongPress(gesture:))))
                    rowStack.addArrangedSubview(btn)
                    btnTagCounter += 1
                }
            }
        }
        updateBoardUI()
    }
    
    private func updateGameInfoUI() {
        switch gameEngine.gameState {
        case GameState.InProgress:
            gameStateLabel.text = C.gameInProgress
        case GameState.PlayerWin:
            gameStateLabel.text = C.playerWin
            timer.invalidate()
        case GameState.PlayerLose:
            gameStateLabel.text = C.playerLose
            timer.invalidate()
        }
        if gameEngine.minesRemaining > 0 {
            if gameEngine.minesRemaining > 99 {
                minesLabel.text = "\(gameEngine.minesRemaining)"
            } else if gameEngine.minesRemaining > 9 {
                minesLabel.text = "0\(gameEngine.minesRemaining)"
            } else {
                minesLabel.text = "00\(gameEngine.minesRemaining)"
            }
        } else {
            minesLabel.text = "000"
        }
    }
    
    private func updateBoardUI() {
        for subView in gameBoard.arrangedSubviews {
            if let rowStack = subView as? UIStackView {
                for subSubView in rowStack.arrangedSubviews {
                    if let btn = subSubView as? UIBoardButton {
                        let (state, content) = gameEngine.getBoardBtnValue(tag: btn.tag)
                        switch content {
                        case BoardBtnContent.Mine:
                            btn.containsMine = true
                        default:
                            btn.containsMine = false
                        }
                        switch state {
                        case BoardBtnState.Unrevealed:
                            btn.isRevealed = false
                            btn.isFlagged = false
                        case BoardBtnState.Revealed:
                            btn.adjMinesCount = gameEngine.getAdjMinesCount(tag: btn.tag)
                            btn.isRevealed = true
                            btn.isFlagged = false
                        case BoardBtnState.Flagged:
                            btn.isRevealed = false
                            btn.isFlagged = true
                        }
                    }
                }
            }
        }
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .ended:
            if gameEngine.gameState == GameState.InProgress {
                if let btn = gesture.view as? UIBoardButton {
                    gameEngine.reveal(tag: btn.tag)
                    updateBoardUI()
                    updateGameInfoUI()
                }
            }
        default:
            break
        }
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            if gameEngine.gameState == GameState.InProgress {
                if let btn = gesture.view as? UIBoardButton {
                    gameEngine.flagOrUnflag(tag: btn.tag)
                    updateBoardUI()
                    updateGameInfoUI()
                }
            }
        default:
            break
        }
    }
    
}
