import UIKit

class HelpViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var helpText: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateHelpUITheme()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Help"
    }
    
    private func updateHelpUITheme() {
        switch Settings.theme {
        case Theme.Light:
            backgroundView.backgroundColor = C.themeLBgColor
            helpText.textColor = C.themeLLabelTextColor
        case Theme.Dark1:
            backgroundView.backgroundColor = C.themeD1BgColor
            helpText.textColor = C.themeD1LabelTextColor
        case Theme.Dark2:
            backgroundView.backgroundColor = C.themeD2BgColor
            helpText.textColor = C.themeD2LabelTextColor
        }
    }
    
}
