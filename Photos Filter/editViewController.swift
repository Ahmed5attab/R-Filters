//
//  editViewController.swift
//  Photos Filter
//
//  Created by Ahmed Khattab on 8/29/19.
//  Copyright © 2019 AhmedKhattab. All rights reserved.
//

import UIKit
class editViewController: UIViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    //Views
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var FiltersView: UIView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var imageFilter: UIImageView!
    @IBOutlet weak var imageCompare: UIImageView!

    let filter = Filters()

    //Main Menu Buttons
    @IBOutlet weak var filtersButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!

    
    @IBAction func Compare(_ sender: Any) {
        if !(imageFilter.image==#imageLiteral(resourceName: "test")){
            UIView.animate(withDuration: 1)
            {
                self.imageFilter.alpha = 0
                self.imageCompare.alpha = 1
            }
        }
    }
    
    
    @IBAction func doneCompare(_ sender: Any) {
        if (imageFilter.image==#imageLiteral(resourceName: "test")){
            self.newImage((Any).self)
        }else{  UIView.animate(withDuration: 2)
        {
            self.imageCompare.alpha = 0
            self.imageFilter.alpha = 1
        }
            
        }
    }
    
      @IBAction func compareClicked(_ sender: Any) {
        if (imageFilter.alpha == 1){
            Compare(sender)
        }else
        {
            doneCompare(sender)
        }
    }
    
    @IBAction func newImage(_ sender: Any) {
       
        let actionSheet = UIAlertController(title: "New Image", message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default, handler: { action in
          let CameraPicker = UIImagePickerController()
            CameraPicker.delegate = self
            CameraPicker.sourceType = .camera
            self.present(CameraPicker, animated: true, completion: nil)
        })
        let album = UIAlertAction(title: "Photos", style: .default, handler: { action in
            let CameraPicker = UIImagePickerController()
            CameraPicker.delegate = self
            CameraPicker.sourceType = .photoLibrary
            self.present(CameraPicker, animated: true, completion: nil)

        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(camera)
        actionSheet.addAction(album)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //Image Picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                UIView.animate(withDuration: 2)
                {
                    self.imageFilter.image = image
                    self.imageCompare.image = image
                    self.filtersButton.isEnabled = true
                }
            }
        
    }
    
    //Share
    
    @IBAction func share(_ sender: Any) {
        let activity = UIActivityViewController(activityItems: [imageFilter.image!], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
    
    //Slider
    @IBOutlet weak var Slider: UISlider!
    var sliderNum = 0
    
    func showSlider(){
        view.addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            sliderView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: -40),
            sliderView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            sliderView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor),
            sliderView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        view.layoutIfNeeded()
        self.sliderView.alpha = 0
        UIView.animate(withDuration:1)
        {
            self.sliderView.alpha = 1
        }
    }
    
    @IBAction func sliderHide(_ sender: Any) {
        Slider.value = 1
        UIView.animate(withDuration:1,animations:{
            self.FiltersView.alpha = 0
        }){ _ in
            self.sliderView.removeFromSuperview()
        }
    }
    

    @IBAction func sliderChange(_ sender: Any) {
        let filterImage = RGBAImage (image: imageCompare.image!)!
        switch sliderNum {
        case 1:
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.cloudy(image: filterImage,Cons: Double(self.Slider.value))
            }
        case 2:
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.warm(image: filterImage,Cons: Double(self.Slider.value))
            }
        case 3:
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.land(image: filterImage, Cons: Double(self.Slider.value))
            }
        case 4:
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.bright(image: filterImage,Cons:Double(self.Slider.value))
            }
        default: break
            
        }

    }

    
    //Filters
    @IBOutlet weak var Normal: UIButton!
    @IBOutlet weak var land: UIButton!
    @IBOutlet weak var bright: UIButton!
    @IBOutlet weak var B_W: UIButton!
    @IBOutlet weak var cloudy: UIButton!
    @IBOutlet weak var Warm: UIButton!
    
    func isNotSelected()
    {
      Normal.isSelected = false
      land.isSelected = false
      bright.isSelected = false
      B_W.isSelected = false
      cloudy.isSelected = false
      Warm.isSelected = false
    }
    
    @IBAction func normal(_ sender: UIButton){
        isNotSelected()
        sender.isSelected = true
        UIView.animate(withDuration: 0.8)
        {
            self.imageFilter.image = self.imageCompare.image
        }
        shareButton.isEnabled = false
        compareButton.isEnabled = false
    }
    
    @IBAction func cloudy(_ sender: UIButton) {
        if (sender.isSelected)
        {
         showSlider()
         sender.isSelected=false
        }else
        {
            isNotSelected()
            sender.isSelected=true
            let filterImage = RGBAImage (image: imageCompare.image!)!
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.cloudy(image: filterImage,Cons: 1)
            }
            sliderNum = 1
            if (shareButton.isEnabled == false)
            {
                activeButtons()
            }
        }
    }
    
    @IBAction func warm(_ sender: UIButton) {
        if (sender.isSelected)
        {
            showSlider()
            sender.isSelected=false
        }else
        {
            isNotSelected()
            sender.isSelected=true
            let filterImage = RGBAImage (image: imageCompare.image!)!
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.warm(image: filterImage,Cons: 1)
            }
            sliderNum = 2
            if (shareButton.isEnabled == false)
            {
                activeButtons()
            }
        }
    }
    
    @IBAction func land(_ sender: UIButton) {
        if (sender.isSelected)
        {
            showSlider()
            sender.isSelected=false
        }else
        {
            isNotSelected()
            sender.isSelected=true
            let filterImage = RGBAImage (image: imageCompare.image!)!
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.land(image: filterImage, Cons: 1)
            }
            sliderNum = 3
            if (shareButton.isEnabled == false)
            {
                activeButtons()
            }
        }
    }
    
    @IBAction func BW(_ sender: UIButton) {
            isNotSelected()
            sender.isSelected=true
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.BW(image: self.imageCompare.image!)
            }
            if (shareButton.isEnabled == false)
            {
                activeButtons()
            }
        
    }
    
    @IBAction func bright(_ sender: UIButton) {
        if (sender.isSelected)
        {
            showSlider()
            sender.isSelected=false
        }else
        {
            isNotSelected()
            sender.isSelected=true
            let filterImage = RGBAImage (image: imageCompare.image!)!
            UIView.animate(withDuration: 0.8)
            {
                self.imageFilter.image = self.filter.bright(image: filterImage,Cons:1)
            }
            sliderNum = 4
            if (shareButton.isEnabled == false)
            {
                activeButtons()
            }
        }}
    
    
    //main menu
    @IBAction func FiltersButtom(_ sender: UIButton) {
        if (sender.isSelected)
        {
            
            UIView.animate(withDuration:1,animations:{
                self.FiltersView.alpha = 0
            }){ _ in
            self.FiltersView.removeFromSuperview()
            sender.isSelected=false
            }
        }else
        {
            self.view.addSubview(self.FiltersView)
            FiltersView.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                FiltersView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: -40),
                FiltersView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
                FiltersView.bottomAnchor.constraint(equalTo: menuView.topAnchor),
                FiltersView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            view.layoutIfNeeded()
            self.FiltersView.alpha = 0
            UIView.animate(withDuration:1)
            {
                self.FiltersView.alpha = 1
            }
            sender.isSelected = true
        }
    }
    
    func activeButtons(){
        shareButton.isEnabled = true
        compareButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageCompare.alpha = 0
        filtersButton.isEnabled = false
        shareButton.isEnabled = false
        compareButton.isEnabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}
