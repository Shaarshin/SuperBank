//
//  API.swift
//  SuperBank
//
//  Created by Shaher Kassam on 2019-07-05.
//  Copyright © 2019 Shaher. All rights reserved.
//

import RxSwift
import Foundation

class API {
    
    static let shared = API()
    
    let bag = DisposeBag()
    
    //MARK : - Without RxSwift
    
    func loadJSONfromfile(completion: (AccountDetails) -> () )  {
        var response: AccountDetails
        var responseRaw: AccountDetailsRaw

        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))

                //Decoding JSON
                responseRaw = try JSONDecoder().decode(AccountDetailsRaw.self, from: data)

                //Creating Account Details
                response = AccountDetails(from: responseRaw)
                //print("JSOn ok", response as Any)

                //Completion
                completion(response)

            } catch {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("No JSON file found")
        }
    }
    
    
    //MARK : - Smal RxSwiftExample
    func loadJSONfromfileRx() -> Observable<AccountDetails> {
        
        return Observable.create { observer -> Disposable in
            
            do {
                let path = Bundle.main.path(forResource: "data", ofType: "json")
                let data = try Data(contentsOf: URL(fileURLWithPath: path ?? String()))
                let responseRaw = try JSONDecoder().decode(AccountDetailsRaw.self, from: data)
                let response = AccountDetails(from: responseRaw)
                observer.onNext(response)
            } catch {
                observer.onError(error)
            }
             observer.onCompleted()
           
            return Disposables.create()
        }
    }
}
