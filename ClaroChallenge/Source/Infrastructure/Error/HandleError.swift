//
//  HandleError.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 27/06/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit
import SwiftMessages

/**
 *  Structure responsible to handle and show error to user, both business and technical errors
 */
struct HandleError {
    // MARK: - Constants
    
    fileprivate static let kDefaultImage = "error"
    
    // MARK: - Public Functions
    
    static func handle(error: Error) {
        
        if let businessError = error as? BusinessError {
            handleBusiness(error: businessError)
        } else if let technicalError = error as? ApiError {
            handleTechnical(error: technicalError)
        } else {
            let messageError = LocalizableStrings.genericError.localize()
            showStatusLine(message: messageError)
        }
    }
    
    // MARK: - Handle Error types
    
    /**
     Handle all types of BusinessError
     
     - parameter error:                BusinessError object
     - parameter navigationController: Instance of current navigationController
     */
    fileprivate static func handleBusiness(error: BusinessError) {
        let errorTitle = LocalizableStrings.friendlyErrorTitle.localize()
        
        switch error {
        case .parse(let message):
            let log = "\(LocalizableStrings.errorParseData.localize()) - (\(message))"
            print(log)
            showDefault(title: errorTitle, description: LocalizableStrings.friendlyError.localize())
        case .offlineMode:
            let message = LocalizableStrings.offlineMode.localize()
            showStatusLine(message: message, durantion: 3)
        case .invalidValue:
            let log = LocalizableStrings.offlineMode.localize()
            print(log)
            showDefault(title: errorTitle, description: LocalizableStrings.friendlyError.localize())
        }
    }
    
    /**
     Handle all types of TechnicalError
     
     - parameter error:                TechnicalError object
     - parameter navigationController: Instance of current navigationController
     */
    fileprivate static func handleTechnical(error: ApiError) {
        let errorTitle = LocalizableStrings.friendlyErrorTitle.localize()
        
        switch error {
        case .httpError(let code):
            let log = "\(LocalizableStrings.httpError.localize()) \(code)"
            print(log)
            showDefault(title: errorTitle, description: LocalizableStrings.friendlyError.localize())
            
        case .invalidURL:
            let log = LocalizableStrings.invalidURL.localize()
            print(log)
            showDefault(title: errorTitle, description: LocalizableStrings.friendlyError.localize())
            
        case .parse(let message):
            let log = "\(LocalizableStrings.errorParseData.localize()) - (\(message))"
            print(log)
            showDefault(title: errorTitle, description: LocalizableStrings.friendlyError.localize())
        }
    }
    
    // MARK: - Present Error types
    
    fileprivate static func showDefault(title: String, description: String) {
        // View setup
        let view = MessageView.viewFromNib(layout: .messageView)
        
        view.configureContent(title: title,
                              body: description,
                              iconImage: nil,
                              iconText: nil,
                              buttonImage: nil,
                              buttonTitle: "Hide",
                              buttonTapHandler: { _ in SwiftMessages.hide() })
        
        view.configureTheme(.info, iconStyle: .default)
        
        // Config setup
        var config = SwiftMessages.Config()
        
        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        config.duration = .forever
        config.dimMode = .none
        config.preferredStatusBarStyle = .default
        
        // Show
        SwiftMessages.show(config: config, view: view)
    }
    
    fileprivate static func showStatusLine(message: String, durantion: TimeInterval = 3) {
        // View setup
        let view = MessageView.viewFromNib(layout: .statusLine)
        
        view.configureContent(body: message)
        view.configureTheme(.info, iconStyle: .light)
        
        // Config setup
        var config = SwiftMessages.Config()
        
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .seconds(seconds: durantion)
        config.dimMode = .none
        config.preferredStatusBarStyle = .lightContent
        
        // Show
        SwiftMessages.show(config: config, view: view)
    }
}
