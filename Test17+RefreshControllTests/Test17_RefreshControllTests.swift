//
//  Test17_RefreshControllTests.swift
//  Test17+RefreshControllTests
//
//  Created by Kholmumin Tursinboev on 2/11/25.
//

import XCTest
@testable import Test17_RefreshControll

final class Test17_RefreshControllTests: XCTestCase {

    func test_refreshControl(){
        let sut = ViewController()
        
        sut.loadViewIfNeeded()
        sut.replaceRefreshControlWithFakeForiOS17Support()
        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
        
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition() 
        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)

        sut.refreshControl?.endRefreshing()
        sut.refreshControl?.sendActions(for: .valueChanged)
        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)
        
        sut.refreshControl?.endRefreshing()
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)

    }

}

private extension ViewController{
    func replaceRefreshControlWithFakeForiOS17Support(){
        let fake = FakeRefreshControl()
        refreshControl = fake
        
        refreshControl?.allTargets.forEach{ target in
            refreshControl?.actions(forTarget: target, forControlEvent: .valueChanged)?.forEach{ action in
                fake.addTarget(target, action: Selector(action), for: .valueChanged)
            }
        }
    }
}

private class FakeRefreshControl: UIRefreshControl{
    private var _isRefreshing = false
    
    override var isRefreshing: Bool {return _isRefreshing}
    
    override func beginRefreshing() {
        _isRefreshing = true
    }
    
    override func endRefreshing() {
        _isRefreshing = false
    }
}
