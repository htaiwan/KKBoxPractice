# KKBoxPractice

KKBox iOS/mac OSX 基本開發教材中

threading這個章節中的練習題，我覺得滿多基本觀念都有練習到

所以抽點時間寫了這個專案，實作這些練習的內容

================================================================

練習內容

- 先拿出我們在 練習：將 Web Service API 包裝成 SDK 當中完成的作業。

- 寫一個叫做 HTTPBinManager 的 singleton 物件。

- 在這個 HTTPBinManager 中，增加一個 NSOperationQueue 的成員變數

- 寫一個叫做 HTTPBinManagerOperation 的 NSOperation subclass， HTTPBinManagerOperation 使用 delegate 向外部傳遞自己的狀態。 HTTPBinManagerOperation 裡頭的 main method 依序要執行：

    - 對我們之前寫的 SDK 發送 fetchGetResponseWithCallback: 並等候回應。

    - 如果前一步成功，先告訴 delegate 我們的執行進度到了 33%，如果失敗就整個取消作業，並且告訴 delegate 失敗。delegate method 要在 main thread 當中執行。

    - 對我們之前寫的 SDK 發送 postCustomerName:callback: 並等候回應。

    - 如果前一步成功，先告訴 delegate 我們的執行進度到了 66%，如果失敗就整個取消作業，並且告訴 delegate 失敗。delegate method 要在 main thread 當中執行

    - 對我們之前寫的 SDK 發送 fetchImageWithCallback: 並等候回應。

    - 如果前一步成功，先告訴 delegate 我們的執行進度到了 100%，並且告訴 delegate 執行成功，並回傳前面抓取到的兩個 NSDcitionary 與一個 UIImage 物件；如果失敗就整個取消作業，並且告訴 delegate 失敗。 delegate method 要在 main thread 當中執行。

- 這個 operation 要實作 cancel，發送 cancel 時，要立刻讓operation 停止，包括清除所有進行中的連線。
- HTTPBinManager 要加入一個叫做 executeOperation 的 method，這個 method 首先會清除 operation queue 裡頭所有的 operation，然後加入新的 HTTPBinManagerOperation。
- HTTPBinManagerOperation 的 delegate 是 HTTPBinManager。 HTTPBinManager 也有自己的 delegate，在 HTTPBinManagerOperation 成功抓取資料、發生錯誤的時候，HTTPBinManager 也會將這些事情告訴自己的 delegate。

- 撰寫單元測試。

- 寫一個 UI，上面有一個按鈕與進度條，按鈕按下後，就會執行 HTTPBinManager 的 executeOperation，然後進度條會顯示 HTTPBinManagerOperation 的執行進度。
