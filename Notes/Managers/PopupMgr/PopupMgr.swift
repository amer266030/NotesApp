//
//  PopupMgr.swift
//  Notes
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import Foundation
import Observation

@Observable
class PopupMgr {
    static let shared = PopupMgr()
    
    var isLoading = false
    var isAlertVisible = false
    
    var isPopupVisible: Bool {
        isLoading || isAlertVisible
    }
    
    var alertTitle: String = ""
    var alertMsg: String = ""
    
    private init() {
        
    }
    
    func showAlert(title: String = "Error", msg: String) {
        isLoading = false
        alertTitle = title
        alertMsg = msg
        isAlertVisible = true
    }
    
    func dismissAlert() {
        alertTitle = ""
        alertMsg = ""
        isAlertVisible = false
    }
}
