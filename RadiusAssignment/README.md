1. Choice of Architecture is MVVM

It promotes a clear separation of concerns, which is crucial in real estate
apps that involve complex data models and interactions. The Model handles the
data and business logic, the View focuses on UI rendering, and the ViewModel
manages the data presentation and user interactions.

Enhances testability by isolating the business logic in the ViewModel. Since
the ViewModel does not have any direct dependency on the UI components, unit
testing becomes easier and more effective.

Utilizes data binding mechanisms to establish a connection between the
ViewModel and the View. This enables automatic synchronization of data between
the two layers. In a property purchase or real estate app, this feature is
particularly useful when displaying real-time property information or
updating property details based on user actions


Real estate apps often involve complex data models and various data sources.
MVVM provides a scalable architecture that can accommodate these complexities.
By centralizing data management and providing a clear separation between
layers, MVVM makes it easier to handle data from different sources, such as
APIs or databases

2. No third party library.But used two icons radio_Btn to show selected and unselected state.

