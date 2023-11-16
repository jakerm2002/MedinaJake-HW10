//
//  ViewController.swift
//  MedinaJake-HW10
//
//  Created by Jake Medina on 11/11/23.
//
//  Filename: MedinaJake-HW10
//  EID: jrm7784
//  Course: CS371L

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // array of images to be displayed in the colection view
    var images: [UIImage] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let picker = UIImagePickerController()
    let imageViewCellIdentifier = "ImageViewCellIdentifier"
    let mainToDetailVCSegueIdentifier = "MainToDetailVCSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        picker.delegate = self
    }
    
    // programatically make the cells square
    // use 3 columns
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        let containerWidth = collectionView.bounds.width
        let numColumns = 3.0
        let cellSize = (containerWidth - 40) / numColumns
        
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // return the corresponding image for a cell from the images array
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageViewCellIdentifier, for: indexPath) as! ImageViewCell
        
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    // go to detail VC when image tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: mainToDetailVCSegueIdentifier, sender: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // once an image is picked, make it appear on the collection view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        images.append(chosenImage)
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    // send a tapped image to detail VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == mainToDetailVCSegueIdentifier,
           let destination = segue.destination as? DetailViewController,
           let selectedItem = collectionView.indexPathsForSelectedItems?[0].row
        {
            destination.image = images[selectedItem]
        }
    }
    
    // bring up photo library
    @IBAction func libraryButtonPressed(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker,animated:true)
    }
    
    // bring up camera, request necessary permissions
    @IBAction func cameraButtonPressed(_ sender: Any) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) {
                    (granted) in
                    guard granted == true else { return }
                }
            case .authorized:
                break
            default:
                let accessDeniedAlert = UIAlertController(title: "No camera access", message: "Access to camera was denied, go to Settings->Privacy->Camera", preferredStyle: .alert)
                accessDeniedAlert.addAction(UIAlertAction(title: "OK", style: .default))
                present(accessDeniedAlert,animated:true)
                return
            }
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            present(picker,animated: true)
            
        } else {
            let noCameraAlert = UIAlertController(title: "No camera", message: "No rear camera detected", preferredStyle: .alert)
            noCameraAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(noCameraAlert,animated:true)
        }
    }
    
}

