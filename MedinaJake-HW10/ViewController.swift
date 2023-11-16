//
//  ViewController.swift
//  MedinaJake-HW10
//
//  Created by Jake Medina on 11/11/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var images: [UIImage] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let picker = UIImagePickerController()
    
    let imageViewCellIdentifier = "ImageViewCellIdentifier"
    
    let mainToDetailVCSegueIdentifier = "MainToDetailVCSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        picker.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        
        let containerWidth = collectionView.bounds.width
        let cellSize = (containerWidth - 40) / 3
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageViewCellIdentifier, for: indexPath) as! ImageViewCell
        
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: mainToDetailVCSegueIdentifier, sender: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // get the selected picture
        let chosenImage = info[.originalImage] as! UIImage
        
        images.append(chosenImage)
        
        collectionView.reloadData()
        
        // dismiss the popover
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == mainToDetailVCSegueIdentifier,
            let destination = segue.destination as? DetailViewController,
           let selectedItem = collectionView.indexPathsForSelectedItems?[0].row
        {
            // destination.delegate = self
            destination.image = images[selectedItem]
        }
    }
    
    
    @IBAction func libraryButtonPressed(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker,animated:true)
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
    }
    
}

