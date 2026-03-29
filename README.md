#masterと比較
git archive -o diff.zip HEAD $(git diff --name-only master..HEAD)
#エリアス設定用
git config --global alias.diffmas "!git archive -o diff.zip HEAD $(git diff --name-only master..HEAD)"

#developと比較
git archive -o diff.zip HEAD $(git diff --name-only develop..HEAD)
#エリアス設定用
git config --global alias.diffdev "!git archive -o diff.zip HEAD $(git diff --name-only develop..HEAD)"