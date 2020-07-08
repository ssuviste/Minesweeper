import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet var mainMenuButtons: [UIButton]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Main Menu"
    }
    
}
