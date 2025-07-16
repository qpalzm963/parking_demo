# 台中停車查詢地圖（Flutter）

本專案是一個 Flutter 製作的**台中停車查詢地圖 App**，  
結合 [交通部 TDX 開放資料 API](https://tdx.transportdata.tw/) 提供**路邊停車格**與**場外（停車場）即時資訊查詢**，  
地圖顯示使用 [flutter_map](https://pub.dev/packages/flutter_map)，  
狀態管理採用 [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)。

---

## 主要功能

- ✅ 顯示台中地區地圖（OpenStreetMap 圖資）
- ✅ 查詢附近路邊停車格
- ✅ 查詢附近場外（公有/民營）停車場
- ✅ 點擊地圖可手動查詢中心附近停車資訊
- ✅ 自動取得使用者目前定位（需權限）
- ✅ 點擊 marker 顯示停車場/停車格詳細資訊
- ✅ 手動移動地圖中心查詢指定地點

---