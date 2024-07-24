//
//  DetailViewController.swift
//  StromViewer
//
//  Created by Hamza Hatem on 20/07/2024.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageNumber = 0
    var totalImages = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "This is image \(selectedImageNumber) of \(totalImages)"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never//title and selectedImage are optionals so no need to unwrap
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
    //function to make share button via email, airdrop, whatsapp, just like normal share
    //marked with objc When you call a method using #selector you’ll always need to use @objc too.
    @objc func shareTapped() {
        //compressionQuality quality of image
        //
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        //UIActivityController is method used for sharing
        //passing 2 parameters, 2 arrays, one for the services offered by app wich is none so the array is left empty
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        //this tells ios to anchor the share popover to the right bar button, only takes effect in ipad on iphone it takes whole screen so is ignored
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        //learned about presennt in project 2
        present(vc, animated: true)
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
