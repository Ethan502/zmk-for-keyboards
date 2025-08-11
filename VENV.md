# Virtual Environment Development Guide

## 🔒 Safe Development with Virtual Environment

你說得對！使用虛擬環境是更安全的做法。這樣可以：

- ✅ **隔離依賴** - 避免影響系統 Python
- ✅ **版本控制** - 確保一致的工具版本
- ✅ **乾淨環境** - 避免套件衝突
- ✅ **易於重建** - 可以輕鬆重新安裝

## 🛠️ 目前環境設定

### Virtual Environment 位置
```bash
/home/re1983/.venv/default
```

### 激活虛擬環境
```bash
source /home/re1983/.venv/default/bin/activate
```

### 已安裝的工具
- **keymap-drawer**: v0.21.0
- **Python**: 系統版本，隔離安裝
- **YAML**: 用於配置文件處理

## 🔧 推薦工作流程

### 1. 每次開始工作時
```bash
cd /home/re1983/extra/Work/zmk-for-keyboards
source /home/re1983/.venv/default/bin/activate
```

### 2. 安全測試
使用 `test-venv.sh` 腳本在虛擬環境中測試：
```bash
bash test-venv.sh
```

### 3. 檢查環境狀態
```bash
which python    # 應該指向 ~/.venv/default/bin/python
which keymap     # 應該指向 ~/.venv/default/bin/keymap
echo $VIRTUAL_ENV # 應該顯示 /home/re1983/.venv/default
```

## 📦 套件管理

### 安裝新套件（安全方式）
```bash
# 先激活虛擬環境
source /home/re1983/.venv/default/bin/activate

# 然後安裝
pip install package-name
```

### 查看已安裝套件
```bash
pip list
```

### 升級 keymap-drawer
```bash
pip install --upgrade keymap-drawer
```

## 🎯 目前狀態

✅ **虛擬環境已激活**  
✅ **keymap-drawer 已安裝** (v0.21.0)  
✅ **配置文件有效**  
✅ **現代化風格已應用**  
⚠️ **本地解析有問題** (使用 GitHub Actions 代替)  

## 🔄 推薦策略

### 本地開發
- 使用虛擬環境進行配置測試
- 驗證 YAML 語法
- 測試新的圖標和樣式

### 實際生成
- 依賴 GitHub Actions 自動化流程
- 避免本地 tree-sitter 相容性問題
- 保持環境乾淨

### 最佳實踐
1. **永遠先激活虛擬環境**
2. **只在虛擬環境中安裝工具**
3. **定期更新虛擬環境**
4. **使用 GitHub Actions 做最終生成**

---

*這樣可以確保開發環境的安全性和一致性，同時避免影響系統其他部分。*
