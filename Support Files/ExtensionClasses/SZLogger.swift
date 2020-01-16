//
//  SZLoggerSupport.swift
//  Logger
//
//  Created by Abservetech on 06/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation

//enum SZLog{
//    case info
//    case warning
//    case error
//    case debug
//    case verbose
//}

var log = SZLog.shared

struct SZLog{
    
    public static var shared = SZLog()
    
    fileprivate func getFormattedDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd-MM-YYYY hh:mm:ss a"
        return dateformat.string(from: Date())
    }
     
    func info(_ info: String){
        print(" ℹ️ " ,getFormattedDate() , " ℹ️ INFO: =>" , info)
    }
    
    func verbose(_ verbose: String){
        print(" 📣 " ,getFormattedDate() , " 📣 VERBOSE: =>" , verbose)
    }
    
    func debug(_ debug: String){
        print(" 📝 ", getFormattedDate() , " 📝 DEBUG: =>" , debug)
    }
    
    func warning(_ warning: String){
        print(" ⚠️ ",getFormattedDate() , " ⚠️ WARNING: =>" , warning)
    }
    
    func error(_ error: String){
        print(" ☠️ ", getFormattedDate() , " ☠️ ERROR: =>" , error)
    }
}
