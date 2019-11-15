//
//  ViewController.swift
//  swf-WKWebView-demo
//
//  Created by S.Emoto on 2018/07/29.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit
import WebKit  // WebKitをインポート

class ViewController: UIViewController {

    private var wkWebView:WKWebView!  // 現時点(2018/07/29)storyboardから作成できないのでコードで生成
    private let demoURL = "https://www.apple.com/jp/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWKWebView()
        load(withURL: demoURL)
    }
}

extension ViewController {
    
    // MARK: - Setup WKWebView
    private func setupWKWebView() {
        
        let webConfig = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: .zero, configuration: webConfig)
        wkWebView.uiDelegate = self  // jsとの連携系
        wkWebView.navigationDelegate = self  // 画面の読み込み・遷移系
        
        view = wkWebView
    }
    
    // MARK: - Load Web Page
    private func load(withURL urlStr:String) {
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        
        wkWebView.load(request)
    }
}

// MARK: - WKNavigationDelegate（画面の読み込み・遷移系）
extension ViewController: WKNavigationDelegate {
    
    // MARK: - 読み込み設定（リクエスト前）
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("読み込み設定（リクエスト前）")
        
        /*
         * WebView内の特定のリンクをタップした時の処理などが書ける
         */
        let url = navigationAction.request.url
        print("読み込もうとしているページのURLが取得できる: ", url ?? "")
        
        /*  これを設定しないとアプリがクラッシュする
         *  .allow  : 読み込み許可
         *  .cancel : 読み込みキャンセル
         */
        decisionHandler(.allow)
    }
    
    // MARK: - 読み込み準備開始
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("読み込み準備開始")
    }
    
    // MARK: - 読み込み設定（レスポンス取得後）
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("読み込み設定（レスポンス取得後）")
        
        /*  これを設定しないとアプリがクラッシュする
         *  .allow  : 読み込み許可
         *  .cancel : 読み込みキャンセル
         */
        decisionHandler(.allow)
        // 注意：受け取るレスポンスはページを読み込みタイミングのみで、Webページでの操作後の値などは受け取れない
    }
    
    // MARK: - 読み込み開始
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("読み込み開始")
    }
    
    // MARK: - ユーザ認証（このメソッドを呼ばないと認証してくれない）
    func webView(_ webView: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("ユーザ認証")
        completionHandler(.useCredential, nil)
    }
    
    // MARK: - 読み込み完了
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("読み込み完了")
    }
    
    // MARK: - 読み込み失敗検知
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError: Error) {
        print("読み込み失敗検知")
    }
    
    // MARK: - 読み込み失敗
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError: Error) {
        print("読み込み失敗")
    }
    
    // MARK: - リダイレクト
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation:WKNavigation!) {
        print("リダイレクト")
    }
}

// MARK: - WKUIDelegate（jsとの連携系）
extension ViewController: WKUIDelegate {}
