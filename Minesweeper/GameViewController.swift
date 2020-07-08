import UIKit

class GameViewController: UIViewController {
    
    private lazy var gameEngine: GameEngine = GameEngine()
    
    private lazy var timer = Timer()
    private var time = 0
    
    @IBOutlet weak var minesLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var gameBoard: UIStackView!
    
    @IBAction func resetButtonTouchUpInside(_ sender: UIButton) {
        timer.invalidate()
        time = 0
        timerLabel.text = "000"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.timerFunc), userInfo: nil, repeats: true)
        gameEngine = GameEngine()
        updateGameInfoUI()
        updateBoardUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        var timeStr = "\(time)"
        if time < 10 {
            timeStr = "00\(timeStr)"
        } else if time < 100 {
            timeStr = "0\(timeStr)"
        }
        if time == 999 {
            timer.invalidate()
        }
        timerLabel.text = "\(timeStr)"
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
            resetButton.setTitle(C.gameInProgress, for: .normal)
        case GameState.PlayerWin:
            resetButton.setTitle(C.playerWin, for: .normal)
            timer.invalidate()
        case GameState.PlayerLose:
            resetButton.setTitle(C.playerLose, for: .normal)
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
