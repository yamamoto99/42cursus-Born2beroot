# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: masayama <masayama@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/02 22:45:38 by masayama          #+#    #+#              #
#    Updated: 2025/05/17 22:20:44 by masayama         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# システムのアーキテクチャ情報を取得
# uname -s: カーネル名を表示（通常はLinux）
# uname -r: カーネルリリース番号を表示（例: 5.4.0-42-generic）
# uname -v: カーネルバージョンを表示（コンパイル日時など）
# uname -m: マシンハードウェア名を表示（例: x86_64）
# uname -o: オペレーティングシステム名を表示（例: GNU/Linux）
# これらのオプションを組み合わせて、システムの完全な基本情報を1行で取得
SYSTEM_ARCH=$(uname -srvmo)

# 物理CPUの数（ソケット数）を取得
# lscpu: システムのCPU情報を詳細表示
# grep "Socket(s):": "Socket(s):"という文字列を含む行を抽出（物理CPUソケット数の行）
# awk '{print $2}': 2列目の数値（ソケット数）だけを出力
# これはマザーボード上の物理的なCPUチップの数を示す
PHYSICAL_CPU_COUNT=$(lscpu | grep "Socket(s):" | awk '{print $2}')

# 仮想CPUの数を取得
# lscpu: システムのCPU情報を表示
# grep "^CPU(s):": 行頭が"CPU(s):"の行だけを抽出（物理CPUの合計コア数）
# awk '{print $2}': 2列目の数値（CPUの数）だけを出力
VIRTUAL_CPU_COUNT=$(lscpu | grep "^CPU(s):" | awk '{print $2}')

# 使用中のメモリ量をMB単位で取得
# free -m: メモリ使用状況をMB単位で表示
# grep Mem: "Mem"という文字列を含む行（メモリの情報行）を抽出
# awk '{print $3}': 3列目の数値（使用中メモリ量）を出力
USED_MEMORY=$(free -m | grep Mem | awk '{print $3}')

# 合計メモリ量をMB単位で取得
# free -m: メモリ使用状況をMB単位で表示
# grep Mem: "Mem"という文字列を含む行（メモリの情報行）を抽出
# awk '{print $2}': 2列目の数値（合計メモリ量）を出力
TOTAL_MEMORY=$(free -m | grep Mem | awk '{print $2}')

# メモリ使用率を百分率で計算（小数点以下2桁まで）
# echo "scale=2; ...": bcコマンドに小数点以下2桁を指定して計算式を渡す
# bc: 計算を実行する基本電卓コマンド
USED_MEMORY_PERCENT=$(echo "scale=2; $USED_MEMORY * 100.0 / $TOTAL_MEMORY" | bc)

# ディスク合計容量をGB単位で取得
# df -h: ディスク使用状況を人間が読みやすい形式で表示
# --block-size=G: 単位をGBに指定
# --total: 全ディスクの合計行を追加
# grep total: "total"を含む行（合計行）を抽出
# awk '{print $2}': 2列目（合計容量）を出力
# cut -f 1 -d G: "G"の前の部分だけを取得（数値のみ）
TOTAL_DISK=$(df -h --block-size=G --total | grep total | awk '{print $2}' | cut -f 1 -d G)

# 使用中ディスク容量をGB単位で取得
# df -h: ディスク使用状況を人間が読みやすい形式で表示
# --block-size=G: 単位をGBに指定
# --total: 全ディスクの合計行を追加
# grep total: "total"を含む行（合計行）を抽出
# awk '{print $3}': 3列目（使用容量）を出力
# cut -f 1 -d G: "G"の前の部分だけを取得（数値のみ）
USED_DISK=$(df -h --block-size=G --total | grep total | awk '{print $3}' | cut -f 1 -d G)

# ディスク使用率を百分率で取得
# df -h: ディスク使用状況を人間が読みやすい形式で表示
# --block-size=G: 単位をGBに指定
# --total: 全ディスクの合計行を追加
# grep total: "total"を含む行（合計行）を抽出
# awk '{print $5}': 5列目（使用率のパーセンテージ）を出力
USED_DISK_PERCENT=$(df -h --block-size=G --total | grep total | awk '{print $5}')

# CPU使用率を計算
# mpstat: CPUの統計情報を表示
# tail -n 1: 最後の行（全CPUの平均値）だけを取得
# awk '{print 100 - $13}': 最終列（%idle）を100から引いてCPU使用率を計算
USED_CPU=$(mpstat | tail -n 1 | awk '{print 100 - $13}')

# 最終起動時間を取得
# who -b: 最後のシステム起動時間を表示
# awk '{print $3 " " $4}': 日付（3列目）と時間（4列目）を取得して結合
LAST_BOOT=$(who -b | awk '{print $3 " " $4}')

# LVMの使用有無を確認
# lsblk: ブロックデバイスの一覧を表示
# grep -q lvm: "lvm"という文字列を含むか確認（-qはquietモード）
# && echo yes || echo no: 存在すれば"yes"、なければ"no"を出力
LVM_USE=$(lsblk | grep -q lvm && echo yes || echo no)

# 確立済みのTCP接続数を取得
# ss -t: TCPソケットの情報を表示
# state established: 確立済み状態の接続だけに絞る
# tail -n +2: ヘッダー行をスキップ（2行目以降を表示）
# wc -l: 行数をカウント（接続数）
CONNECTIONS_TCP=$(ss -t state established | tail -n +2 | wc -l)

# ログイン中のユーザー数を取得
# who: 現在ログインしているユーザーの一覧を表示
# wc -l: 行数をカウント（ユーザー数）
LOGIN_USER_COUNT=$(who | wc -l)

# IPアドレスを取得
# hostname -I: ホストのすべてのIPアドレスを表示
IP_ADD=$(hostname -I)

# MACアドレスを取得
# ip link show: ネットワークインターフェイスの情報を表示
# grep link/ether: 物理（イーサネット）アドレス行を抽出
# awk '{print $2}': 2列目のMACアドレス部分だけを出力
MAC_ADD=$(ip link show | grep link/ether | awk '{print $2}')

# sudoコマンドの実行回数を取得
# grep -a COMMAND /var/log/sudo/sudo.log: sudoログから"COMMAND"を含む行を抽出（バイナリファイルもテキストとして処理）
# wc -l: 行数をカウント（sudoコマンド実行回数）
SUDO_LOG=$(grep -a COMMAND /var/log/sudo/sudo.log | wc -l)

wall <<EOF
#Architecture: $SYSTEM_ARCH
#CPU physical: $PHYSICAL_CPU_COUNT
#vCPU: $VIRTUAL_CPU_COUNT
#Memory Usage: $USED_MEMORY/$TOTAL_MEMORY MB ($USED_MEMORY_PERCENT%)
#Disk Usage: $USED_DISK/$TOTAL_DISK GB ($USED_DISK_PERCENT)
#CPU Load: $USED_CPU%
#Last boot: $LAST_BOOT
#LVM use: $LVM_USE
#Connections TCP: $CONNECTIONS_TCP
#User log: $LOGIN_USER_COUNT
#Network: IP $IP_ADD ($MAC_ADD)
#Sudo: $SUDO_LOG cmd
EOF
