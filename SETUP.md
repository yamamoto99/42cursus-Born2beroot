# VirtualBox セットアップ方法

## 仮想マシンの作成

### ISO イメージの取得

このリポジトリでは `Debian` を利用して環境構築を行います。  
自身のマシンに合致する最新の`ISOイメージ`を [公式サイト](https://www.debian.org/distrib/netinst) からダウンロードしてください。  
プロセッサの確認は、ターミナルで右記のコマンドを実行して行います: `uname -m`

※ `x86_64` は `amd64` と同等です。

- `x86_64`: x86 アーキテクチャを 64bit に拡張したもの
- `amd64`: AMD 社が発表した、x86 アーキテクチャを 64bit に拡張したもの

### 仮想マシンの作成

1. まず VirtualBox を開き、`新規`をクリックします。  
   仮想マシンに適当な名前を付け、ダウンロードした`ISOイメージ`を選択します。  
   データの保存に関してはホームディレクトリが制限されているため、`sgoinfre`もしくは外付けディスクの利用を検討してください。  
   `自動インストールをスキップ`を選択し、次へ進みます。
2. 次に仮想マシンのハードウェアメモリ量と仮想 CPU 数を設定します。  
   `4096MB`と`4vCPU`を選択し、次へ進みます。  
   スペックに余裕がある場合は、もちろん性能を上げることが可能です。
3. 次に仮想 HDD のサイズを設定します。20GB で十分ですが、[LVM のサイズを PDF に合わせたい場合](#ディスクのパーティショニング)は、PDF 記載の SIZE を指定してください。  
   `仮想ハードディスクを作成する`を選択し、20GB 確保します。  
   `全サイズの事前割り当て`を選択し、次へ進みます。
4. 最終確認です。下記表の通りに設定が完了していたら完了をクリックして仮想マシンの作成を完了します。  
   指定したディレクトリにマシン名がついたディレクトリが作成されていることを確認してください。

#### 仮想マシン設定項目

| 分類                 | 設定項目                   | 値                               |
| -------------------- | -------------------------- | -------------------------------- |
| マシン名と OS タイプ | マシン名                   | 任意の名前                       |
|                      | マシンフォルダー           | 任意のフォルダ (例: sgoinfre 等) |
|                      | ISO イメージ               | ダウンロードした ISO イメージ    |
|                      | ゲスト OS のタイプ         | Debian (64-bit)                  |
|                      | 自動インストールのスキップ | true                             |
| ハードウェア         | メインメモリー             | 4096                             |
|                      | プロセッサー数             | 4                                |
|                      | EFI 有効                   | false                            |
| ディスク             | ディスクサイズ             | 20.00 GB                         |
|                      | 全サイズの自動割り当て     | true                             |

## オペレーティングシステムのインストール

続いて、オペレーティングシステムのインストールを行います。以下の手順に沿って進めてください。

### 言語設定とユーザー作成

1. VirtualBox の GUI から `起動` を選択します。  
   （今回は GUI は使用せず、通常の `Install` を選択します。）
2. 言語設定で`English`を選択し、場所は`Japan`、`en_US.UTF-8`、キーボード設定は`American English`にして次へ進みます。
3. `Host name`を入力します。課題要件に従い、`intraログイン名+42` を入力してください。
4. `Domain name`は今回は設定せず、空欄のまま次へ進みます。
5. `Root password` を設定します。（後で変更しますが、課題要件のパスワードポリシーに従って作成してください。）
6. 新規ユーザーの作成に進みます。
   - `Full name for the new user`
   - `Username for your account`  
     いずれも、課題要件に従い `intraログイン名` を入力して次へ進みます。
7. 最後にパスワードを設定し（後で変更しますが、課題要件のパスワードポリシーに従って作成してください。）、ユーザー設定を完了させます。

### ディスクのパーティショニング

#### Mandatory

> [!NOTE]
> LVM のサイズを PDF と一致させる作業は行なっていません。

1. パーティショニングの方法から`Guided - use entire disk and set up encrypted LVM`を選択します。
2. パーティショニング機構から`Separate /home partition`を選択します。
3. 確認メッセージが出るので`Yes`を選択します。
4. 暗号化用のパスワードが要求されるので、設定します。課題のパスワード要件はここには適用されません。  
   ※このパスワードは`VM起動時`に求められるので、記憶する必要があります。  
   ※簡単すぎる場合、脆弱なパスワードをこのまま利用するかの確認画面が出ることがあります。
5. ガイドによるパーティショニングを利用するボリュームのサイズを選択します。ここでは`15GB`を入力します。
6. `Finish partitioning and write changes to disk`を選択し、パーティショニングを終了します。
7. パーティション設定の変更内容をディスクに書き込む確認が出るので、`Yes`を選択します。

#### Bonus

> [!NOTE]
> LVM のサイズを PDF と一致させる作業は行なっていません。

> [!NOTE]
> 下記の方法以外にもパーティショニングの方法でマニュアルを選択し、一から構築する方法があります。

1. パーティショニングの方法から`Guided - use entire disk and set up encrypted LVM`を選択します。
2. パーティショニング機構から`Separate /home, /var, and /tmp partitions`を選択します。
3. 確認メッセージが出るので`Yes`を選択します。
4. 暗号化用のパスワードが要求されるので、設定します。課題のパスワード要件はここには適用されません。  
   ※このパスワードは`VM起動時`に求められるので、記憶する必要があります。  
   ※簡単すぎる場合、脆弱なパスワードをこのまま利用するかの確認画面が出ることがあります。
5. ガイドによるパーティショニングを利用するボリュームのサイズを選択します。ここでは`15GB`を入力します。
6. まず、LVM グループの名前を変更します。`Go Back`を選択し、`Execute a shell`を選択します。
7. 確認が出るので`Continue`を選択します。
8. terminal で`vgrename <hostname>-vg LVMGroup`を実行します。  
   ※`<hostname>`は自身が設定した、マシンの hostname を入力してください。
9. 次に swap 領域の名前を変更します。terminal で`lvrename LVMGroup swap_1 swap`を実行します。
10. terminal から`exit`して、menu から`Partition disks`に戻ります。
11. `Configure the Logical Volume Manager`を選択します。
12. `srv`を作成します。
    - `Create logical volume`を選択します。
    - ボリュームグループを選択（選択肢が 1 つの場合はそのままで OK）
    - `Logical volume name`を `srv` に設定
    - ボリュームサイズを `4000MB` に設定
13. 次に`var-log`を作成します。
    - `Create logical volume`を選択します。
    - ボリュームグループを選択（選択肢が 1 つの場合はそのままで OK）
    - `Logical volume name`を `var-log` に設定
    - ボリュームサイズを `1950MB` に設定
14. `Finish`を選択してパーティションの設定画面へ戻ります。
15. 次にパーティション設定画面から LVM 内の`/var/log用の論理ボリューム（2.0GB）`を選択し、設定を行います。
    - パーティション設定の`Use as : do not use`を選択します。
    - パーティションの利用方法から`Ext4 Journaling file system`を選択します。
    - マウントポイントを選択する際、デフォルトで`/var/log`が存在しないので、`Enter manually`から手動で追加してください。
    - ジャーナリングファイルシステムが`Ext4 Journaling file system`、マウントポイントが`/var/log`になっていることを確認します。
    - 設定を終了します。
16. 同じような設定を`home`,`root`,`tmp`にも適用します。
    ジャーナリングファイルシステムが`Ext4 Journaling file system`、マウントポイントはそれぞれ対応したパスを選択します。
17. 次にパーティション設定画面から LVM 内の`swap用の論理ボリューム（1.0GB）`を選択し、設定を行います。
    - パーティション設定の`Use as : do not use`を選択します。
    - パーティションの利用方法から`swap area`を選択します。
    - 設定を終了します。
18. `Finish partitioning and write changes to disk`を選択し、パーティショニングを終了します。
19. パーティション設定の変更内容をディスクに書き込む確認が出るので、`Yes`を選択します。

### その他の設定

1. 追加のメディアをスキャンするか確認が出ますが、`いいえ`を選択します。
2. `Debian archive mirror country`から`日本`を選択します。
3. `Debian archive mirror`から`deb.debian.org`を選択します。
4. HTTP プロキシの情報は無いので空のまま続行します。
5. ソフトウェアの選択では`SSH server`、`standard system utilities`の 2 つを選択し、続行します。  
   ※スペースを利用して選択、解除ができます。
6. `Install the GRUB boot loader to your primary drive?`と質問された場合、`Yes`を選択し、`/dev/sda`を選択します。
7. インストールが完了したら`reboot`してください。

以上でオペレーティングシステムのインストールは完了です。  
`Please unlock disk sda5_crypt`と聞かれたらパーティション時に設定した暗号化キーを入力してください。

## SHH の設定

ここからは Linux システムの設定を行います。  
まず初めは SSH の設定です。  
まず、先ほど作成した VM に root ユーザーでログインし、以下のコマンドで SSH サービスの状態を確認してください。

```shell
systemctl status ssh
```

ステータスが "active (running)" で、ポート 22 をリッスンしていることを確認します。  
課題要件により、SSH はポート 4242 でリッスンし、root ユーザーでの SSH ログインを禁止する必要があります。  
そのため、SSH 設定ファイル (`/etc/ssh/sshd_config`) を以下のように編集してください。  
コメント状態の場合、デフォルト設定が適用されるため、必ずコメントは解除する必要があります。

変更前

```shell
#Port22

#PermitRootLogin prohibit-password
```

変更後

```
Port 4242

PermitRootLogin no
```

編集後 SSH サービスを再起動します。

```shell
systemctl restart ssh
```

次に、VirtualBox の GUI でポートフォワーディングの設定を行います。

1. 仮想マシンの設定から「ネットワーク」→「詳細設定」→「ポートフォワーディング」に移動します。
2. 「新規ポートフォワーディングルールを追加」をクリックし、以下を入力してください。
   - 名前：SSH
   - プロトコル：TCP
   - ホスト IP：（空欄）
   - ホストポート：ホスト PC で空いている任意のポート番号
   - ゲスト IP：（空欄）
   - ゲストポート：4242

上記設定完了後、仮想マシンからログアウトし、ホスト PC から以下のコマンドで SSH 接続を行います。

```shell
ssh <username>@localhost -p <設定したホストポート>
```

SSH 接続が確立すると、ログイン先のシェルプロンプトが以下のように表示されます。

```shell
<username>@<hostname>:~$
```

## ファイアウォール(UFW)

次に、UFW の設定を行います。  
root ユーザーでログインしてください。  
もし SSH 経由でアクセスしている場合は、以下で root ユーザーに切り替えます。  
その後、以下の手順で UFW を設定します。

1. UFW をインストールする  
   `apt install ufw`
2. すべての受信リクエストを拒否する  
   `ufw default deny incoming`
3. すべての送信リクエストを許可する  
   `ufw default allow outgoing`
4. ポート 4242 への受信を許可する  
   `ufw allow 4242`
5. UFW を有効化する  
   `ufw enable`

設定後、以下のコマンドで UFW の状態を確認し、4242 ポートが開放されていることを確認してください。

```shell
ufw status
```

↓ 出力例

```
root@login42:~# ufw status
Status: active

To                         Action      From
--                         ------      ----
4242                       ALLOW       Anywhere
4242 (v6)                  ALLOW       Anywhere (v6)
```

## SUDO

次に sudo の設定を行います。
下記コマンドを実行し、sudo をインストールします。

```shell
apt install sudo
```

次に sudo の設定を行います。下記コマンドを入力し、sudo の設定ファイルを開きます。

```shell
visudo
```

続けて下記の設定を行います。

```shell
Defaults	env_reset
Defaults	mail_badpass
Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# -----以下追加部分-----
# sudo利用時にTTYを必須に
Defaults	requiretty
# sudoで間違ったパスワードを入力するとカスタムメッセージを表示
Defaults	badpass_message="WRONG PASSWORD"
# 入力ログファイルを設定
Defaults	logfile="/var/log/sudo/sudo.log"
# 入力を記録
Defaults	log_input
# 出力を記録
Defaults	log_output
# 追加の出力ログと入力ログを保存するディレクトリを設定
Defaults	iolog_dir=/var/log/sudo
# sudoを使用した接続試行を制限
Defaults	passwd_tries=3
```

## グループ

課題要件ではユーザーを`user42`と`sudo`のグループに所属させる必要があります。  
まずは下記コマンドで`user42`グループを作成します。

```shell
groupadd user42
```

続いて、下記コマンドで、ユーザーを`sudo`及び`user42`グループに追加します。

```shell
usermod -aG user42,sudo <username>
```

下記コマンドでユーザーが正常にグループに所属しているか確認します。

```shell
groups <username>
```

## パスワード

課題要件ではパスワードポリシーについて厳格な規定が存在します。  
このパートではパスワードポリシーの設定を行います。  
パスワードポリシー設定ファイル（`/etc/login.defs`）に移動し、`Password aging controls`の項目を下記の通り変更します。

```shell
# Password aging controls:
#
#       PASS_MAX_DAYS   Maximum number of days a password may be used.
#       PASS_MIN_DAYS   Minimum number of days allowed between password changes.
#       PASS_WARN_AGE   Number of days warning given before a password expires.
#
PASS_MAX_DAYS   30
PASS_MIN_DAYS   2
PASS_WARN_AGE   7
```

> [!WARNING]
> ここで行ったパスワードポリシーの変更を下記コマンドを用いて、既存のユーザーと root ユーザーに適用する必要があります。

```shell
chage -M 30 root
chage -m 2 root
chage -M 30 <username>
chage -m 2 <username>
```

また、ユーザーのパスワードポリシーの確認は下記コマンドを利用します。

```shell
chage -l <username>
```

続いて、パスワードポリシーを強化するために、`pwquality`モジュールを下記コマンドでインストールします。

```shell
apt install libpam-pwquality
```

次に`/etc/pam.d/common-password`にアクセスし、パスワードルールを変更します。

変更前

```shell
# here are the per-package modules (the "Primary" block)
password        requisite                       pam_pwquality.so retry=3
```

変更後

```shell
# here are the per-package modules (the "Primary" block)
password        requisite                       pam_pwquality.so retry=3 minlen=10 difok=7 maxrepeat=3 dcredit=-1 ucredit=-1 lcredit=-1 reject_username enforce_for_root
```

> [!WARNING]
> 新しいルールを適用後、下記コマンドを用いて、既存ユーザーと root ユーザーのパスワードを更新する必要があります。

```shell
passwd <username>
```

## モニタリングスクリプト

課題要件より、`cron`を利用して、10 分ごとにスクリプトを実行し、マシン状態を標準出力する必要があります。  
下記コマンドを用いて、`cron`の設定を行います。

```shell
crontab -e
```

下記設定を記載することで、10 分ごとに`monitoring.sh`が実行されます。

```shell
*/10 * * * * bash /etc/cron.d/monitoring.sh
```

`monitoring.sh`のサンプルは[こちら](monitoring.sh)

</br>
</br>
<h3 align="center">
   もし設定で誤っている点がありましたら、ご連絡ください。
<h3>
