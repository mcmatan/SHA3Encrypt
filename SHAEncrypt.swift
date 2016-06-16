//
//  SHA3Encrypt.swift
//  JiveIdentity
//
//  Created by Matan Cohen on 6/16/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

import Foundation
import JavaScriptCore



public class SHAEncrypt {
    private var cryptoJScontext = JSContext()
    private var SHA3: JSValue!
            
            init(){
                
                // Retrieve the content of md5.js
                let cryptoJSpath = NSBundle.mainBundle().pathForResource("sha3", ofType: "js")
                
                if(( cryptoJSpath ) != nil){
                    
                    do {
                        let cryptoJS = try String(contentsOfFile: cryptoJSpath!, encoding:NSUTF8StringEncoding)
                        
                        print("Loaded sha3My.js")
                        
                        // Evaluate md5.js
                        cryptoJScontext.evaluateScript(cryptoJS)
                        
                        // Reference functions
                        self.SHA3 = cryptoJScontext.objectForKeyedSubscript("sha3_256")
                    }
                    catch {
                        print("Unable to load md5.js")
                    }
                    
                }else{
                    print("Unable to find md5.js")
                }
                
            }
            
            public func hash(string: String)->String {
                return "\(self.SHA3.callWithArguments([string]))"
            }
    
}