//
//  ViewController.swift
//  Encypted and Descrypt
//
//  Created by iMac on 1/16/17.
//  Copyright © 2017 NemSothea. All rights reserved.
//

import UIKit
import RNCryptor
import CryptoSwift

class ViewController: UIViewController {
    
    //Encypt Outlet
    @IBOutlet weak var stringToEn: UITextField!
    @IBOutlet weak var keyEn: UITextField!
    @IBOutlet weak var outputEn: UITextField!
    
    //Descrypt Outlet
    @IBOutlet weak var stringToDes: UITextField!
    @IBOutlet weak var keyDes: UITextField!
    @IBOutlet weak var outputDes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func encyptPressed(_ sender: Any) {
        let input = stringToEn.text
        let key = keyEn.text
        let iv = "gqLOHUioQ0QjhuvI"
        let en = try! input!.aesEncrypt(key: key!, iv: iv)
        outputEn.text = en
        
        
    }
    @IBAction func descyptPressed(_ sender: Any) {
        let input = stringToDes.text
        let key = keyDes.text
        let iv = "gqLOHUioQ0QjhuvI"
        let des = try! input!.aesDecrypt(key: key!, iv: iv)
        outputDes.text = des
        
    }

}
extension String{
    func aesEncrypt(key: String, iv: String) throws -> String {
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self)!
        let decrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    
    }
}

