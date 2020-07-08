import UIKit

class HelpViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var helpText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Help"
    }
    
}
