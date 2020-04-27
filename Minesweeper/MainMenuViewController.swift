//
//  MainMenuViewController.swift
//  Minesweeper
//
//  Created by Anonymous on 21.04.2020.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        updateUITheme()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Main Menu"
    }
    
    func updateUITheme() {
        print("3")
        switch Settings.theme {
        case Theme.Light:
            backgroundView.backgroundColor = C.themeLBgColor
            gameNameLabel.textColor = C.themeLLabelTextColor
            newGameButton.setTitleColor(C.themeLBtnTextColor, for: .normal)
            settingsButton.setTitleColor(C.themeLBtnTextColor, for: .normal)
            helpButton.setTitleColor(C.themeLBtnTextColor, for: .normal)
            newGameButton.backgroundColor = C.themeLBtnBgColor
            settingsButton.backgroundColor = C.themeLBtnBgColor
            helpButton.backgroundColor = C.themeLBtnBgColor
        case Theme.Dark1:
            backgroundView.backgroundColor = C.themeD1BgColor
            gameNameLabel.textColor = C.themeD1LabelTextColor
            newGameButton.setTitleColor(C.themeD1BtnTextColor, for: .normal)
            settingsButton.setTitleColor(C.themeD1BtnTextColor, for: .normal)
            helpButton.setTitleColor(C.themeD1BtnTextColor, for: .normal)
            newGameButton.backgroundColor = C.themeD1BtnBgColor
            settingsButton.backgroundColor = C.themeD1BtnBgColor
            helpButton.backgroundColor = C.themeD1BtnBgColor
        case Theme.Dark2:
            return
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
