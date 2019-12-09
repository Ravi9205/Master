//
//  ArticleListVC.swift
//  NYArticle
//
//  Created by Ravi dwivedi on 08/12/19.
//  Copyright © 2019 Ravi dwivedi. All rights reserved.
//

import UIKit

class ArticleListVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var responseArr:Array<Dictionary<String,Any>> = []
    var articleListArr = [ArticleList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.separatorColor = UIColor.clear
        getArticleList()
    }
    
    
    
}

extension ArticleListVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ArticleCell", for:indexPath) as! ArticleCell
        cell.lbl_title.text = articleListArr[indexPath.row].title
        cell.lbl_publishedDate.text = articleListArr[indexPath.row].published_date
        let mediaArr =  articleListArr[indexPath.row].media
        if let media_dict = mediaArr?[0] as? Dictionary<String,Any>{
            cell.lbl_createdBy.text = media_dict["copyright"] as? String
            if let arr_media = media_dict["media-metadata"] as? Array<Any>{
                
                if let img_dict = arr_media[0] as? Dictionary<String,Any>{
                    cell.imgView.setImage(with:img_dict["url"] as? String, placeHolder:UIImage.init(named:"DefaultImage"))
                }
                
            }
            
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 140.0
    }
    
}

//MARK:- API Call
extension ArticleListVC:WebServiceDelegate{
    
    func getArticleList(){
        let webservice = WebService()
        webservice.delegate = self
        DispatchQueue.main.async {
            self.startActivity()
        }
        let url = Base.articleList.rawValue+Constants.string.api_Key+api_Key
        webservice.getDataFromUrlWithGET(url: url, requestName:Base.articleList.rawValue)
        
    }
    
    //MARK:- Delegate Method API Call and respose get
    func dataReceiveFromService(dic:Dictionary<String,Any> ,requestName:String){
        DispatchQueue.main.async {
            self.stopActivity()
            switch requestName{
            case Base.articleList.rawValue :
                if dic.keys.contains("results"){
                    self.responseArr = dic["results"] as! Array<Dictionary<String,Any>>
                    print("Data Array\(self.responseArr)")
                    
                    self.responseArr .forEach({ (dict) in
                        let article = ArticleList(data:dict as [String:Any])
                        self.articleListArr.append(article)
                    })
                    self.tableView.reloadData()
                    
                }else{
                    self.showAlertMessage(titleStr:Constants.string.app_name, messageStr:Constants.string.somethingWentWrong)
                }
                break
            default:
                print("default")
            }
            
        }
    }
    
    //MARK:- Fail to get response...
    func dataFailure(error:String,requestName:String){
        DispatchQueue.main.async {
            self.stopActivity()
            self.showAlertMessage(titleStr:Constants.string.app_name, messageStr:error)
        }
        
        print(error)
    }
    
    
    
}
