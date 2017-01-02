//  LoginController.swift
//  DF_app
//
//  Created by Prang on 12/13/2559 BE.
//  Copyright © 2559 Prang. All rights reserved.
//

import UIKit
import Firebase


/*
struct Adress {
    var province: String
    var state: String
}
struct Users {
    var address: Adress
    var email: String
}
*/


class LoginController: UIViewController {
    let inputsContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginSignUp: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius=20
        button.backgroundColor = UIColor(r: 237, g: 163, b: 71)
        button.setTitle("SIGN UP", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self,action:#selector(handleSignup),for:.touchUpInside)
        return button
    }()
    
        //ฟังก์ชั่นสมัครสมาชิก
    func handleSignup() {
        guard  let email = emailTextField.text, let password = passwordTextField.text,let name=nameTextField.text else{
        print("form is wrong")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion:{(user:FIRUser?,Error)in
            
            if Error != nil{
            print(Error)
                return
            
            }
            guard let uid = user?.uid else{
            return
            }
                //เสร็จ เก็บค่าได้
            let ref = FIRDatabase.database().reference(fromURL:"https://dontforget-a6f7a.firebaseio.com/") // ใส่ลิงค์เพื่อใส่ข้อมูลลงในfirebase
            let usersReference = ref.child("users").child(uid) //ใส่ซับดาต้าเบส
            let values = ["name":name,"email":email]
            
            usersReference.updateChildValues(values,withCompletionBlock:{
            (err,ref)in
                if err != nil{
                print(err)
                    return
                
                }
                
                
                print("Add into Firebase db")
            
            })

        
            })
       
    }
    
    let nameTextField: UITextField = {
        let tf = UITextField()
       tf.attributedPlaceholder = NSAttributedString(string:"USERNAME",attributes:[NSForegroundColorAttributeName: UIColor.white])
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.textColor = UIColor.white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:"EMAIL",attributes:[NSForegroundColorAttributeName: UIColor.white])
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.textColor = UIColor.white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string:"PASSWORD",attributes:[NSForegroundColorAttributeName: UIColor.white])
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.textColor = UIColor.white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry=true
        
        
        return tf
    }()
    //ส่วนที่โชว์โลโก้แอป
    lazy var  profileImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppDflogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfile)))
            imageView.isUserInteractionEnabled = true
            
        
        return imageView
    }()
    
   
    
    //ปุ่มล็อกอิน
    let loginRegisSegment: UIButton = {
        let sc = UIButton() //ทำให้ปุ่มกดได้ ขอค้างไว้แปป
        sc.layer.cornerRadius=20
        sc.backgroundColor = UIColor(r: 83, g: 173, b: 193)
        sc.setTitle("LOG IN", for: .normal)
        sc.translatesAutoresizingMaskIntoConstraints = false
       sc.setTitleColor(UIColor.white, for: .normal)
        sc.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
       sc.addTarget(self,action:#selector(handleLoginchangepage),for:.touchUpInside)
    
        return sc
    }()
    
    func handleLoginchangepage(sender: UIButton)  {
        
        let loginchangpage=LogChangePController()
        present(loginchangpage,animated:true,completion:nil)
    }

    
    
    
    
    //setค่าเพื่อโชว์อะไรในตรงส่วนนี้
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 239, g: 104, b: 96)
        view.addSubview(inputsContainerView)
        view.addSubview(loginSignUp)
        view.addSubview(loginRegisSegment)
        view.addSubview(profileImageView)
        setupInputsContainerView()
        
        setupLoginRegisterButton()
        setupLoginBut()
        setupProfileImageView()
    }
    
    
    
    //setค่าเพื่อโชว์อะไรในตรงส่วนนี้
   
    func setupLoginBut() {
        
        loginRegisSegment.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive=true
        
        loginRegisSegment.topAnchor.constraint(equalTo: loginSignUp.bottomAnchor, constant: 12).isActive = true
        loginRegisSegment.widthAnchor.constraint(equalTo: loginSignUp.widthAnchor).isActive = true
        loginRegisSegment.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
    }
    
    
    
    //ส่วนของฟังก์ชั่นที่เรียกใช้งาน
    func setupProfileImageView() {
        //need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    func setupInputsContainerView() {
        //need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        
        //ค่าความสูงกว้าง ของเทกซ์ฟิล
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
        //ค่าความสูงกว้าง ของช่องระหว่างเทกซ์ฟิลล์ ชื่อ
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        //ค่าความสูงกว้าง อีเมล์
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
       
        
        //ค่าความสูงกว้าง ของช่องระหว่างเทกซ์ฟิลล์ อีเมล์

        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        //ค่าความสูงกว้าง ของช่องระหว่างเทกซ์ฟิลล์ พาสเวิด

        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    func setupLoginRegisterButton() {
       
        //ค่าความสูงกว้าง ของช่องล็อกอิน

        loginSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginSignUp.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginSignUp.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginSignUp.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    

    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent //or default
    }
}

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red:r/255,green:g/255,blue:b/255,alpha:1)
        
    }

}
