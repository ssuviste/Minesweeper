//
//  SettingsViewController.swift
//  Minesweeper
//
//  Created by Anonymous on 21.04.2020.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var rowsLabel: UILabel!
    @IBOutlet weak var colsLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var customMinesLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Settings"
        updateSettingsUI()
    }
    
    @IBAction func rowsDecreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.rows <= C.minRows) {
            Settings.rows = C.minRows
        } else {
            Settings.rows -= 1
        }
        updateSettingsUI()
    }
    
    @IBAction func rowsIncreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.rows >= C.maxRows) {
            Settings.rows = C.maxRows
        } else {
            Settings.rows += 1
        }
        updateSettingsUI()
    }
    
    @IBAction func colsDecreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.cols <= C.minCols) {
            Settings.cols = C.minCols
        } else {
            Settings.cols -= 1
        }
        updateSettingsUI()
    }
    
    @IBAction func colsIncreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.cols >= C.maxCols) {
            Settings.cols = C.maxCols
        } else {
            Settings.cols += 1
        }
        updateSettingsUI()
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
        updateSettingsUI()
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
        updateSettingsUI()
    }
    
    @IBAction func customMinesDecreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.minesCustom <= C.minMinesCustom) {
            Settings.minesCustom = C.minMinesCustom
        } else {
            Settings.minesCustom -= 10
        }
        updateSettingsUI()
    }
    
    @IBAction func customMinesIncreaseButtonTouchUpInside(_ sender: UIButton) {
        if (Settings.minesCustom >= C.maxMinesCustom) {
            Settings.minesCustom = C.maxMinesCustom
        } else {
            Settings.minesCustom += 10
        }
        updateSettingsUI()
    }
    
    @IBAction func themeDecreaseButtonTouchUpInside(_ sender: UIButton) {
        switch Settings.theme {
        case Theme.Light:
            return
        case Theme.Dark1:
            Settings.theme = Theme.Light
        case Theme.Dark2:
            Settings.theme = Theme.Dark1
        }
        updateSettingsUI()
        
        if let ns = navigationController?.viewControllers {
            for n in ns {
                print("test")
            }
        }
    }
    
    @IBAction func themeIncreaseButtonTouchUpInside(_ sender: UIButton) {
        switch Settings.theme {
        case Theme.Light:
            Settings.theme = Theme.Dark1
        case Theme.Dark1:
            Settings.theme = Theme.Dark2
        case Theme.Dark2:
            return
        }
        updateSettingsUI()
    }
    
    private func updateSettingsUI() {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
