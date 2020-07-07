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
        updateSettingsUITheme()
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
        case Theme.Dark1:
            return
        case Theme.Dark2:
            Settings.theme = Theme.Dark1
        case Theme.Light:
            Settings.theme = Theme.Dark2
        }
        updateSettingsLabels()
        updateSplitViewMainMenu()
        updateSettingsUITheme()
    }
    
    @IBAction func themeIncreaseButtonTouchUpInside(_ sender: UIButton) {
        switch Settings.theme {
        case Theme.Dark1:
            Settings.theme = Theme.Dark2
        case Theme.Dark2:
            Settings.theme = Theme.Light
        case Theme.Light:
            return
        }
        updateSettingsLabels()
        updateSplitViewMainMenu()
        updateSettingsUITheme()
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
        case Theme.Light:
            themeLabel.text = "L"
        case Theme.Dark1:
            themeLabel.text = "D1"
        case Theme.Dark2:
            themeLabel.text = "D2"
        }
    }
    
    private func updateSplitViewMainMenu() {
        let navVC = (self.splitViewController?.viewControllers.first) as? UINavigationController
        if let vcs = navVC?.viewControllers {
            for v in vcs {
                if let menu = v as? MainMenuViewController {
                    menu.updateMainMenuUITheme()
                }
            }
        }
    }
    
    private func updateSettingsUITheme() {
        switch Settings.theme {
        case Theme.Light:
            backgroundView.backgroundColor = C.themeLBgColor
            for label in settingsTextLabels {
                label.textColor = C.themeLLabelTextColor
            }
            for button in settingsButtons {
                button.backgroundColor = C.themeLBtnBgColor
            }
        case Theme.Dark1:
            backgroundView.backgroundColor = C.themeD1BgColor
            for label in settingsTextLabels {
                label.textColor = C.themeD1LabelTextColor
            }
            for button in settingsButtons {
                button.backgroundColor = C.themeD1BtnBgColor
            }
        case Theme.Dark2:
            backgroundView.backgroundColor = C.themeD2BgColor
            for label in settingsTextLabels {
                label.textColor = C.themeD2LabelTextColor
            }
            for button in settingsButtons {
                button.backgroundColor = C.themeD2BtnBgColor
            }
        }
    }

}
