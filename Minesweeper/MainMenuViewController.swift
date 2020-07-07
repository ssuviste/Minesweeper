import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet var mainMenuButtons: [UIButton]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        updateMainMenuUITheme()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Main Menu"
    }
    
    func updateMainMenuUITheme() {
        switch Settings.theme {
        case Theme.Light:
            backgroundView.backgroundColor = C.themeLBgColor
            gameNameLabel.textColor = C.themeLLabelTextColor
            for button in mainMenuButtons {
                button.setTitleColor(C.themeLBtnTextColor, for: .normal)
                button.backgroundColor = C.themeLBtnBgColor
            }
        case Theme.Dark1:
            backgroundView.backgroundColor = C.themeD1BgColor
            gameNameLabel.textColor = C.themeD1LabelTextColor
            for button in mainMenuButtons {
                button.setTitleColor(C.themeD1BtnTextColor, for: .normal)
                button.backgroundColor = C.themeD1BtnBgColor
            }
        case Theme.Dark2:
            backgroundView.backgroundColor = C.themeD2BgColor
            gameNameLabel.textColor = C.themeD2LabelTextColor
            for button in mainMenuButtons {
                button.setTitleColor(C.themeD2BtnTextColor, for: .normal)
                button.backgroundColor = C.themeD2BtnBgColor
            }
        }
    }
    
}
