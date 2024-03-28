//
//  HaksikBuilder.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RIBs

protocol HaksikDependency: Dependency {
    var userDataService: UserDataService { get }
}

final class HaksikComponent: Component<HaksikDependency>,
                             HaksikInteractorDependency,
                             MealPlanCardsDependency {
    let haksikService: HaksikService
    
    let userDataService: UserDataService
    
    let universityInfoService: UniversityInfoService
    
    let mutableSelectedCafeteriaIDStream: MutableSelectedCafeteriaIDStream
    
    let mutableSelectedDateStream: MutableSelectedDateStream
    
    var selectedCafeteriaIDStream: SelectedCafeteriaIDStream {
        mutableSelectedCafeteriaIDStream
    }
    
    var selectedDateStream: SelectedDateStream {
        mutableSelectedDateStream
    }
    
    override init(dependency: HaksikDependency) {
        let localFileName = "CAUMeals"
        
        let remoteCollectionName = "CAU_Haksik"
        
        let remoteDocumentName: String
        #if DEBUG
        remoteDocumentName = "Test_Doc"
        #else
        remoteDocumentName = "CAU_Cafeteria_Menu"
        #endif
        
        haksikService = HaksikServiceImpl(
            repository: MealPlanCompositeRepositoryImpl(
                remoteRepository: MealPlanJsonRemoteRepositoryImpl(
                    collection: remoteCollectionName,
                    document: remoteDocumentName
                ),
                localRepository: MealPlanJsonLocalRepositoryImpl(
                    localFileName: localFileName
                )
            )
        )
        
        userDataService = dependency.userDataService
        
        universityInfoService = UniversityInfoServiceImpl(
            repository: MockUniversityRepositoryImpl()
        )
        
        mutableSelectedCafeteriaIDStream = SelectedCafeteriaIDStreamImpl()
        
        mutableSelectedDateStream = SelectedDateStreamImpl()
        
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol HaksikBuildable: Buildable {
    func build(withListener listener: HaksikListener) -> HaksikRouting
}

final class HaksikBuilder: Builder<HaksikDependency>,
                           HaksikBuildable {

    override init(dependency: HaksikDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: HaksikListener
    ) -> HaksikRouting {
        
        let component = HaksikComponent(
            dependency: dependency
        )
        let viewController = HaksikViewController()
        let interactor = HaksikInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        
        let mealPlanCardsBuilder = MealPlanCardsBuilder(
            dependency: component
        )
        
        return HaksikRouter(
            interactor: interactor,
            viewController: viewController,
            mealPlanCardsBuilder: mealPlanCardsBuilder
        )
    }
}
