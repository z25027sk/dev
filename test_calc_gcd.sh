#!/bin/bash

SCRIPT="./calc_gcd.sh"
EXIT_CODE=0

# テスト実行関数
run_test() {
    local description="$1"
    local expected_output="$2"
    local expected_status="$3"
    shift 3
    local result output

    echo "テスト: $description"
    output=$($SCRIPT "$@" 2>&1)
    result=$?

    if [ "$result" -ne "$expected_status" ]; then
        echo " 期待された終了コード: $expected_status, 実際: $result"
        echo "出力: $output"
        EXIT_CODE=1
    elif [ "$expected_status" -eq 0 ] && [ "$output" != "$expected_output" ]; then
        echo " 出力が一致しません"
        echo "期待: $expected_output"
        echo "実際: $output"
        EXIT_CODE=1
    else
        echo " OK"
    fi

    echo ""
}

# --------------------------
# 正常系テスト
# --------------------------
run_test "通常: 60 と 48 の最大公約数" "12" 0 60 48
run_test "大きな値: 12345678901234567890 と 10" "10" 0 12345678901234567890 10

# --------------------------
# 異常系テスト
# --------------------------
run_test "引数不足（0個）" "" 1
run_test "引数過多（3個）" "" 1 10 20 30
run_test "0を含む（自然数でない）" "" 1 0 5
run_test "負数を含む" "" 1 -10 5
run_test "文字列を含む" "" 1 abc 123
run_test "桁数超過" "" 1 1234567890123456789012345678901 5

exit $EXIT_CODE
