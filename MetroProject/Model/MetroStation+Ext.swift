import Foundation

extension MetroStation {
    var displayName: String {
        // إذا حقل nameAr فيه نص وغير فارغ، اعرضه فوراً
        // إذا كان فارغ، وقتها بس اعرض الإنجليزي
        return !nameAr.isEmpty ? nameAr : nameEn
    }
}

extension MetroLine {
    var displayName: String {
        return !nameAr.isEmpty ? nameAr : nameEn
    }
}
