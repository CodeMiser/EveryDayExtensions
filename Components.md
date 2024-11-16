#  EveryDay Components

## NetworkAPI

### Purpose

1. Centralized API Management:
- Holds a reference to NetworkSession, which manages headers, base URLs, and network requests.
2. Extension-Based Organization:
- Specific API endpoints (e.g., fetchUsers) are implemented via extensions to NetworkAPI, keeping the core class clean.
3. Application Access:
- Global let api = NetworkAPI() enables application wide access to all NetworkAPI extension methods. 

## NetworkSession

### Purpose

1. Holds the Global API State:
- Encapsulates the Base URL and HTTP Header Fields
2. Uses the Foundation Network API to implement network requests
- `perform(request:)` collaborates with the `NetworkRequest to form the `URLRequest` and drive the `URLSession`

### Key Dynamics:

1. Thread Performance vs. Safety 
- Returns control to the main thread to ensure reliable operation within view controllers
2. Networking Testability
- Implements a networkLinkConditionerResponseDelay constant to trivially enable stress-testing

## NetworkRequest

### Purpose

- Single-line implementation of async netwoork request methods

### Key Dynamics:

1. Explit Endpoint Relationship:
- HTTP method, path, and parameters
2. Flexible Asynchronous Operation:
- Available `completion` closure parameters include Void, Bool, NetworkResponse?, and NetworkResponse?, NetworkError   
3. Optional Caching:
- Via the `execute` method `cacheType: CacheType` parameter
3. Optional Paging:
- Via the specialized `executePaging` method 

## NetworkCollection (Paging)

### Purpose

- Extends NetworkRequest to promote collection types to a first-class type, and enable fully-encapsulated paging.

### Key Dynamics:

1. View Gating the Paging:
- The UITableView triggers prefetching only when the user scrolls near the end of the currently loaded rows.
- This means the API is only queried when the UI needs more data, reducing unnecessary requests.
2. Paging Gating the View:
- The isFetching set ensures only one request is in progress at any time.
- Until the current page’s data is appended, the threshold for the next prefetch isn’t crossed, preventing duplicate or overlapping requests.
3. Page Size & Margin:
- The pageSize (e.g., 20 items) is tuned to exceed 2 * visibleCells.count - margin (e.g., 10–15 items depending on screen size and margins).
- This ensures there’s always enough data loaded to scroll smoothly without gaps, even during slower network conditions.

### Why It’s Robust:

- No Overfetching: Only one page is fetched at a time, minimizing API load and avoiding redundant data.
- No Underfetching: Prefetching starts early enough (e.g., 5 rows before the end) to ensure data is ready when the user reaches it.
- Self-Balancing: The view and paging logic naturally synchronize to maintain a steady flow of data.

This setup strikes a great balance between responsiveness and efficiency. Paging can scale seamlessly with any dataset size or network conditions.

## NetworkCache

### Purpose

- Supports caching by the NetworkRequest

### Key Dynamics:

1. Agnostic:
- Caching of Data objects makes elminates coupling to the application's NetworkResponse types.
2. Fleixible:
- Supports memory, and disk caching via UserDefaults

### Why It’s Robust:

- It's not. Up to 512KB should be OK. But for heavyweight applications, a new implementation is recommended.
