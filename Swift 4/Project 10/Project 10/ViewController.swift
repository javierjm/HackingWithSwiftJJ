//
//  ViewController.swift
//  Project 10
//
//  Created by Javier Jara on 10/11/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let test : String = CellIdentifier.PersonCell
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionView Datasource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Don't forget to add as! PersonCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.PersonCell, for: indexPath) as! PersonCell
        
        let person = people[indexPath.item]
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.name.text = person.name
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    // MARK: UICollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        let ac = UIAlertController(title: "Renaem Person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Save", style: .default) { [unowned self, ac] _ in
            let newName = ac.textFields![0]
            person.name = newName.text!
            
            self.collectionView?.reloadData()
        })
        present(ac, animated: true)
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        let person = Person(name: "Unknown", image:imageName)
        people.append(person)
        collectionView?.reloadData()
        
        if let jpegData = UIImageJPEGRepresentation(image, 80) {
            try? jpegData.write(to:imagePath)
        }
        
        dismiss(animated: true)
    }
    
    // Selector Methods
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    // Private Methods
    

    fileprivate func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
        
    }
}

