import UIKit
import WebKit

class WebViewController: UIViewController{

    //MARK: - View Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = VK_API().requestLoginView()
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
}

//MARK: - Extension WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        guard let token = VK_API().getToken(fragment: fragment) else {
            return
        }
        UserDefaults.standard.set(token, forKey: "userToken")
        performSegue(withIdentifier: "logined", sender: nil)
        decisionHandler(.cancel)
    }
}
