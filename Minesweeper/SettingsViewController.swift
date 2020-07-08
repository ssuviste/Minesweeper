import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var settingsTextLabels: [UILabel]!
    @IBOutlet var settingsButtons: [UIButton]!
    
    @IBOutlet weak var rowsLabel: UILabel!
    @IBOutlet weak var colsLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var customMinesLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateSettingsLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Settings"
    }
    
    @IBAction func rowsDecreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.rows <= C.minRows) {
            Settings.rows = C.minRows
        } else {
            Settings.rows -= 1
        }
        updateSettingsLabels()
    }
    
    @IBAction func rowsIncreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.rows >= C.maxRows) {
            Settings.rows = C.maxRows
        } else {
            Settings.rows += 1
        }
        updateSettingsLabels()
    }
    
    @IBAction func colsDecreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.cols <= C.minCols) {
            Settings.cols = C.minCols
        } else {
            Settings.cols -= 1
        }
        updateSettingsLabels()
    }
    
    @IBAction func colsIncreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.cols >= C.maxCols) {
            Settings.cols = C.maxCols
        } else {
            Settings.cols += 1
        }
        updateSettingsLabels()
    }
    
    @IBAction func difficultyDecreaseButtonTouchUpInside(_ sender: UIButton) {
        switch Settings.difficulty {
        case Difficulty.L1:
            return
        case Difficulty.L2:
            Settings.difficulty = Difficulty.L1
        case Difficulty.L3:
            Settings.difficulty = Difficulty.L2
        case Difficulty.Custom:
            Settings.difficulty = Difficulty.L3
        }
        updateSettingsLabels()
    }
    
    @IBAction func difficultyIncreaseTouchUpInside(_ sender: UIButton) {
        switch Settings.difficulty {
        case Difficulty.L1:
            Settings.difficulty = Difficulty.L2
        case Difficulty.L2:
            Settings.difficulty = Difficulty.L3
        case Difficulty.L3:
            Settings.difficulty = Difficulty.Custom
        case Difficulty.Custom:
            return
        }
        updateSettingsLabels()
    }
    
    @IBAction func customMinesDecreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.minesCustom <= C.minMinesCustom) {
            Settings.minesCustom = C.minMinesCustom
        } else {
            Settings.minesCustom -= 10
        }
        updateSettingsLabels()
    }
    
    @IBAction func customMinesIncreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.minesCustom >= C.maxMinesCustom) {
            Settings.minesCustom = C.maxMinesCustom
        } else {
            Settings.minesCustom += 10
        }
        updateSettingsLabels()
    }
    
    @IBAction func themeDecreaseButtonTouchUpInside(_ sender: UIButton) {
        switch Settings.theme {
        case Theme.T1:
            return
        case Theme.T2:
            Settings.theme = Theme.T1
        case Theme.T3:
            Settings.theme = Theme.T2
        }
        updateSettingsLabels()
    }
    
    @IBAction func themeIncreaseButtonTouchUpInside(_ sender: UIButton) {
        switch Settings.theme {
        case Theme.T1:
            Settings.theme = Theme.T2
        case Theme.T2:
            Settings.theme = Theme.T3
        case Theme.T3:
            return
        }
        updateSettingsLabels()
    }
    
    private func updateSettingsLabels() {
        rowsLabel.text = "\(Settings.rows)"
        colsLabel.text = "\(Settings.cols)"
        customMinesLabel.text = "\(Settings.minesCustom)%"
        
        switch Settings.difficulty {
        case Difficulty.L1:
            difficultyLabel.text = "1"
        case Difficulty.L2:
            difficultyLabel.text = "2"
        case Difficulty.L3:
            difficultyLabel.text = "3"
        case Difficulty.Custom:
            difficultyLabel.text = "Custom"
        }
        
        switch Settings.theme {
        case Theme.T1:
            themeLabel.text = "T1"
        case Theme.T2:
            themeLabel.text = "T2"
        case Theme.T3:
            themeLabel.text = "T3"
        }
    }

}
