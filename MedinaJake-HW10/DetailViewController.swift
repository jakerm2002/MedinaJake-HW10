//
//  DetailViewController.swift
//  MedinaJake-HW10
//
//  Created by Jake Medina on 11/16/23.
//
//  Filename: MedinaJake-HW10
//  EID: jrm7784
//  Course: CS371L

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    
    // set the image using the image passed from Main VC
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }

}
