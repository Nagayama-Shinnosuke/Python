import os
import zipfile

# 対象フォルダ
TARGET_DIR = "diff/J3CMSEXP"
ZIP_NAME = "diff/J3CMSEXP.zip"

if not os.path.exists(TARGET_DIR):
    print("J3CMSEXPフォルダが存在しません")
    exit()

with zipfile.ZipFile(ZIP_NAME, 'w', zipfile.ZIP_DEFLATED) as zipf:
    for root, dirs, files in os.walk(TARGET_DIR):
        for file in files:
            full_path = os.path.join(root, file)
            # zip内のパス（J3CMSEXP配下を維持）
            rel_path = os.path.relpath(full_path, "diff")
            zipf.write(full_path, rel_path)

print("ZIP作成完了:", ZIP_NAME)