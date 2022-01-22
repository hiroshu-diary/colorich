# ColoRich 心を満たす色日記（カラリッチ） 　
### リリース
#### 　[App Store](https://apps.apple.com/jp/app/id1605445070)　　　　[Google Play](https://play.google.com/store/apps/details?id=com.hiroshu.colorich)　　　　　
<img width="1500" alt="ColoRIch_RM" src="https://user-images.githubusercontent.com/96947875/150629296-0191ca0a-345b-4213-8979-e9e25ce71586.png">

### ファイル
#### dice
d_model　→10進法・16進法の変換用ファイル  
d_view_z →色選択時の、３つ目のランダムカラーピッカー

##### model
one_piece →日記保存用のクラス  
sqliteファイル　→DB

#### view_model
function →汎用するfunctionのまとめ

#### view
laugh_tail_view →ホーム画面  
log_view →ホーム画面のFABを長押しで出る、RGBの累計円グラフ  
new_world_view →ホーム画面のFABを押して出る、新規作成画面  
settings_view　→設定画面、Cardの切り替え・通知など  
upd_piece_view　→更新及び削除画面  
