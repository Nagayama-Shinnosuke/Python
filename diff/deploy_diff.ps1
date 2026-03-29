param(
    [string]$Base = "main",
    [string]$Target = "feature",
    [string]$Output = "deploy"
)

Write-Host "=== 差分抽出開始 ==="

# 出力フォルダ初期化
if (Test-Path $Output) {
    Remove-Item -Recurse -Force $Output
}
New-Item -ItemType Directory -Path $Output | Out-Null

# 差分取得
$diff = git diff --name-status $Base..$Target

foreach ($line in $diff) {
    $parts = $line -split "`t"
    $status = $parts[0]
    $file = $parts[1]

    if ($status -eq "D") {
        # 削除ファイル記録
        Add-Content -Path "$Output/delete_list.txt" -Value $file
        continue
    }

    # フォルダ作成
    $dest = Join-Path $Output $file
    New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null

    # ファイル取得（バイナリ対応）
    git show "${Target}:$file" | Out-File -Encoding byte $dest
}

Write-Host "=== 完了：$Output フォルダを確認してください ==="