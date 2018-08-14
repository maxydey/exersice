//
//  exersiceTests.swift
//  exersiceTests
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxSwift

import RxBlocking
import RxNimble

@testable import exersice



class ServiceSpec: QuickSpec {
    override func spec() {
        let service = NetworkService(testing: true)
        
        describe("When requesting global data") {
             let getData = service.getGlobalData()
            var error: Error?
            var result: [GlobalData]

            do {
                result = try getData.asObservable().toBlocking().toArray()
                print(result)
            } catch let e {
                result = []
                error = e
            }
            
            it("Has to be one responce") {
                expect(result.count).to(equal(1))
            }
            
            it("Should not fail") {
                expect(error).to(beNil())
            }
        }
        
        describe("When requesting Tickers") {
            let getData = service.getTickers()
            var error: Error?
            var result: [Ticker.Batch]
            
            do {
                result = try getData.asObservable().toBlocking().toArray()
                print(result)
            } catch let e {
                result = []
                error = e
            }
            
            it("Has to be one responce") {
                expect(result.count).to(equal(1))
            }
            
            it("Should not fail") {
                expect(error).to(beNil())
            }
        }
        
        describe("When requesting Image") {
            let getData = service.getImage(path: "123123")
            var error: Error?
            var result: [UIImage?]
            
            do {
                result = try getData.asObservable().toBlocking().toArray()
                print(result)
            } catch let e {
                result = []
                error = e
            }
            
            it("Has to be one responce") {
                expect(result.count).to(equal(1))
            }
            
            it("Should not fail") {
                expect(error).to(beNil())
            }
        }
        
        describe("When requesting Tickers and server returns error") {
            let getData = service.getTickersAndFail()
            var error: Error?
            var result: [Ticker.Batch]

            do {
                result = try getData.asObservable().toBlocking().toArray()
                print(result)
            } catch let e {
                result = []
                error = e
            }
            
            it("Has not be a responce") {
                expect(result.count).to(equal(0))
            }
            
            it("Should not fail") {
                expect(error).notTo(beNil())
            }
        }
    }
    
    
}
