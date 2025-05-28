#!/bin/bash

# ログファイル
LOG_FILE="./calc_gcd.log"
# 最大桁数
#MAX=20

# ログ出力
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# エラー出力
err_msg() {
    log "エラー終了: $1"
    echo "エラー: $1" >&2
    echo "使用方法: $0 <自然数> <自然数>" >&2
    exit 1
}

# 引数の数チェック
if [ "$#" -ne 2 ]; then
    err_msg "引数の数が正しくありません（指定数: $#）"
fi

# ログに引数を記録
log "実行開始: 引数1='$1', 引数2='$2'"

# 引数の数チェック
#for arg in "$1" "$2"; do
#    # 自然数１以上か？
#    if ! [[ "$arg" =~ ^[1-9][0-9]*$ ]]; then
#        err_msg "自然数（1以上の整数）を指定してください（指定値: '$arg'）"
#    fi
#
#    # 桁数は？
#    if [ "${#arg}" -gt "$MAX" ]; then
#        err_msg "自然数は最大 ${MAX} 桁までです（指定値: '$arg'）"
#    fi
#done

# 自然数1以上の整数かをチェック
for arg in "$1" "$2"; do
    if ! [[ "$arg" =~ ^[1-9][0-9]*$ ]]; then
        err_msg "自然数（1以上の整数）を指定してください（指定値: '$arg'）"
    fi
done

# 最大公約数関数（ユークリッドの互除法）
#calc_gcd() {
#    local a=$1
#    local b=$2
#
#    while [ "$b" -ne 0 ]; do
#        local temp=$b
#        b=$((a % b))
#        a=$temp
#    done
#
#    echo "$a"
#}

calc_gcd() {
    echo "
    define gcd(a, b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }
    gcd($1, $2)
    " | bc
}

# ログに結果を書き込む
RESULT=$(calc_gcd "$1" "$2")
log "最大公約数: $RESULT"

# 計算結果を表示
echo "$RESULT"

