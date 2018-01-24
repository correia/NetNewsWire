//
//  Article+Scriptability.swift
//  Evergreen
//
//  Created by Olof Hellman on 1/23/18.
//  Copyright © 2018 Olof Hellman. All rights reserved.
//

import Foundation
import Account
import Data

@objc(ScriptableArticle)
class ScriptableArticle: NSObject, UniqueIdScriptingObject {

    let article:Article
    let container:ScriptingObjectContainer
    
    init (_ article:Article, container:ScriptingObjectContainer) {
        self.article = article
        self.container = container
    }

    @objc(objectSpecifier)
    override var objectSpecifier: NSScriptObjectSpecifier? {
        let scriptObjectSpecifier = self.container.makeFormUniqueIDScriptObjectSpecifier(forObject:self)
        return (scriptObjectSpecifier)
    }

    // MARK: --- ScriptingObject protocol ---

    var scriptingKey: String {
        return "articles"
    }

    // MARK: --- UniqueIdScriptingObject protocol ---

    // articles have id in the Evergreen database and id in the feed
    // article.uniqueID here is the feed unique id

    var scriptingUniqueId:Any {
        return article.uniqueID
    }
    
    // MARK: --- Scriptable properties ---
    
    @objc(url)
    var url:String  {
        return article.url ?? ""
    }
    
    @objc(uniqueId)
    var uniqueId:String  {
        return article.uniqueID
    }
    
    @objc(title)
    var title:String  {
        return article.title ?? ""
    }

    @objc(contents)
    var contents:String  {
        return article.contentText ?? ""
    }

    @objc(html)
    var html:String  {
        return article.contentHTML ?? ""
    }

    @objc(summary)
    var summary:String  {
        return article.summary ?? ""
    }

    @objc(datePublished)
    var datePublished:Date?  {
        return article.datePublished
    }

    @objc(dateModified)
    var dateModified:Date?  {
        return article.dateModified
    }

    @objc(dateArrived)
    var dateArrived:Date  {
        return article.status.dateArrived
    }

    @objc(read)
    var read:Bool  {
        return article.status.boolStatus(forKey:.read)
    }

    @objc(starred)
    var starred:Bool  {
        return article.status.boolStatus(forKey:.starred)
    }

    @objc(deleted)
    var deleted:Bool  {
        return article.status.boolStatus(forKey:.userDeleted)
    }

    @objc(imageURL)
    var imageURL:String  {
        return article.imageURL ?? ""
    }
}
