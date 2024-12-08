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
    
    var loadingMsg: String = ""
    
    var alertTitle: String = ""
    var alertMsg: String = ""
    
    private init() {
        
    }
    
    func showLoading(_ msg: String = "Loading...") {
        loadingMsg = msg
        if !isLoading {
            isLoading = true
        }
    }
    
    func dismissLoading() {
        isLoading = false
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
