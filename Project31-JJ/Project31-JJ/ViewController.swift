import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var addresBar: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setDefaultTitle()
        
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action:#selector(addWebView))
        let delete = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(deleteWebView))
            
        navigationItem.rightBarButtonItems = [delete, add]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Private Methods 
    
    func setDefaultTitle() {
        title = "Multibrowser"

    }

    func addWebView() {
        let webView = UIWebView()
        webView.delegate = self
        stackView.addArrangedSubview(webView)
        let url = NSURL(string: "https://www.hackingwithswift.com")!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func deleteWebView() {
        
    }
    
    // MARK - UIWebViewDelegate
}

