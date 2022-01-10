import RxSwift




protocol HomeNewsUseCaseProtocol {
    func getNews(type:storeType,searchTerm:String)->Observable<NewsModel>
}


class HomeNewsUseCase:HomeNewsUseCaseProtocol{
    
    var homeNewsRepo:NewsRepoProtocol
    
    init(homeNewsRepo:NewsRepoProtocol){
        self.homeNewsRepo = homeNewsRepo
    }
    
    func getNews(type: storeType, searchTerm: String) -> Observable<NewsModel>{
        switch type{
        case .network:
            print("network")
            return self.homeNewsRepo.getNews(with:searchTerm)
            
        case .cache:
            print("cashe")
            return self.homeNewsRepo.getNews(with:searchTerm)
        }
    }
}
