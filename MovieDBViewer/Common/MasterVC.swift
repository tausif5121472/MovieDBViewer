//
//  MasterVC.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import UIKit

class MasterVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func loadinHubShow(showAt: UIView) {
        
        let _ = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.color = .black
        loadingIndicator.startAnimating();
        
        let jeremyGif = UIImage.gifImageWithName("funny")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: loadingIndicator.bounds.origin.x, y: loadingIndicator.bounds.origin.y, width: 50, height: 50)
        
        loadingIndicator.addSubview(imageView)
        //alert.view.addSubview(loadingIndicator)
        showAt.addSubview(loadingIndicator)
        loadingIndicator.center = showAt.center
        
    }
    
    func loadinHubDismiss() {
        dismiss(animated: false, completion: nil)
    }
}
