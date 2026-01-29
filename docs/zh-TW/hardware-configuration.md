# Hardware Configuration

Connect the USB 3.0 cable to the USB slot on your computer. After confirming the connection is complete, you can turn on the software and connect the signal cable to the device under test for observation.

## Master device features

The TravelLogic master device includes the following components:

- Indicator LED
- Reference clock out
- Reference clock in
- Trigger out
- Trigger in
- USB 3.0 Type B slot (connects to computer)
- Pin assignment


訊號量測問題 通常有以下幾個原因:
1- 探棒電容負載較大時, 會把高頻雜訊濾掉, 反而會看起來很乾淨, 但實際的高頻訊號其實也被濾除
2- 引線過長, 引入電感負載 把高頻增益拉大, 頻響規格較低的儀器反而會看不出來
3- 頻率規格愈高的儀器 在接線不理想條件下 會看到更糟糕的結果, 因為它能讓高頻訊號通過, 呈現出更多的雜訊反應
4- 測量訊號的引線 與 自身迴路的地線 距離遠遠近近, 造成阻抗變異 引起多重反射, 所以 測試訊號配對的地線 就要接在訊號旁邊
5- 測量引線 是由 原電路 拉引線出來, 形成 電路分支/stub 造成阻抗斷點, 需加 20~50 ohm 電阻 避免二次反射
6- 不同探棒的 輸入阻抗 與 引線 的配置不同, 所以與 DUT 連接後的現象也會有差異, 但如果引線夠短 且能避免二次反射 以及 訊號/Gnd 保持近距離以維持阻抗穩定, 那這樣才會符合儀器本身的規格~
