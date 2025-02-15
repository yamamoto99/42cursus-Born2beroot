<h1 align="center">
 42Cursus Born2beroot
</h1>

<p align="center">
  <img src="born2beroote.png" />
</p>

# Setup

### [VM セットアップ方法](SETUP.md)

# Key Points

<details>
<summary>仮想マシンの基本機能</summary>

ソフトウェアを用いて、一台のコンピューター内に擬似的に再現したコンピューターを作る技術である。

</details>

<details>
<summary>仮想マシンを用いる理由</summary>

仮想マシンは実際のホストと分離された独立した環境を提供できるため、ソフトウェアの開発、動作検証などに適している。  
また、本番と同等の環境を簡単に用意することができるため、開発者依存のエラーを防ぐことができる。

</details>

<details>
<summary>RockyとDebianの基本的な違い</summary>

Linux ディストリビューションは、大きく分けて以下の 3 系統に分類される。

- #### RedHat 系

  RedHat 社が開発する`Red Hat Enterprise Linux`とその派生ディストリビューションで、企業向けサーバー用途で広く採用されている。

- #### Debian 系

  ボランティアによって開発される Debian を中心に、その派生である Ubuntu など、一般利用に適したディストリビューションである。

- **その他**

#### Rocky

RedHat 系に属し、企業環境向けに設計されている。

#### Debian

は Ubuntu のベースとなるディストリビューションで、通常の利用に向いている。

</details>

<details>
<summary>aptitudeとaptの違い</summary>

- #### apt

  `apt`は従来の`apt-get`と`apt-cache`の機能を統合し、よりシンプルなコマンド体系でパッケージ管理を行えるように設計されたツールである。  
  日常的なパッケージのインストール、削除、更新などの操作がわかりやすく、エラーメッセージも簡潔である。

- #### aptitude
  `aptitude`は`apt-get`をベースにして開発されたパッケージ管理ツールだが、より高度な依存関係の解決や推奨パッケージの管理が可能である。  
  また、テキストベースの`GUI（TUI）`モードを備えており、ユーザーが視覚的にパッケージの状態を把握しやすい設計である。

</details>

<details>
<summary>AppArmorとは</summary>

`AppArmor`は、プログラムが不必要にファイルやデバイスにアクセスするのを防ぐセキュリティの仕組みである。  
例えば、あるプログラムがアクセスできる場所を制限することで、万が一の不正アクセスや悪意ある動作からシステムを守ることができる。  
また、プログラムが起動する際にセキュリティルールを適用し、内部のサブプロセスにも同様の制約をかけることができる。  
`chmod`はファイルそのもののアクセス権を制御するのに対して、`AppArmor`は各プログラムに対してシステム側でルールを設定し制御を行う。

</details>

<details>
<summary>LVM (Logical Volume Manager)とは</summary>

`LVM`は、複数のディスクやパーティションをひとつのボリュームグループにまとめ、単一の論理ボリュームとして扱うことができるディスク管理機能です。  
【特徴・メリット】

- 複数のディスクやパーティションの記憶領域を統合し、1 つの巨大な論理ボリュームとして利用できる。
- ボリュームサイズの拡張や縮小、また物理ボリュームの追加が柔軟に行える。

</details>

<details>
<summary>パーティションとは</summary>

パーティションとは、1 つの物理ディスクを複数の論理的な領域に分割する仕組み。  
これにより、OS からはあたかも複数の独立したディスクが存在するかのように認識され、データの管理やシステムの運用が柔軟になる。

</details>

<details>
<summary>UFW とは</summary>

UFW (Uncomplicated Firewall) は、シンプルで使いやすいファイアウォール管理ツールです。  
不要なポートを閉じ、必要なポートだけを開放することで、外部からの不正アクセスや攻撃のリスクを低減できます。

</details>

<details>
<summary>SSHとは</summary>

SSH (Secure Shell) は、リモートコンピュータと安全に通信するためのプロトコルです。  
全ての通信が暗号化されるため、ネットワーク上での盗聴や改ざんを防ぐことができます。

※プロトコルとは、コンピューター同士が通信する際に定められたルールや手順、通信規格

</details>

<details>
<summary>ポートフォワーディングとは</summary>

ホスト OS からゲスト OS への SSH 接続を実現するために、ポートフォワーディングを設定します。  
ポートフォワーディングとは、インターネットから特定のポート番号に向けて届いたパケットを、あらかじめ設定した LAN 内の別の機器（この場合はゲスト OS）に転送する機能です。

例えば、ホスト OS 上で直接 `ssh -p 4242 user@hostname` コマンドを実行すると、ホスト OS の`4242`ポートへ接続が試みられます。  
そのため、正しくゲスト OS に SSH 接続するためには、ホスト OS の`4242`ポートへの接続をゲスト OS に転送するように、ポートフォワーディングを事前に設定する必要があります。

</details>

<details>
<summary>Cronとは</summary>

`Cron`とは、Unix 系システムで利用される定期実行タスクのスケジューラです。  
ユーザーや管理者が設定した特定の日時や間隔に応じて、自動的にコマンドやスクリプトを実行してくれます。

</details>

## マシンの仮想ディスクの署名の確認

下記コマンドを利用してハッシュ値を確認します。

```shell
shasum <~~~~~>.vdi
```

## 仮想マシンの状態を確認するコマンド

### 起動しているマシンのオペレーティングシステムを調べる

オペレーティングシステムの基本情報は、主に`/etc/os-release`に格納されています。  
このファイルには、ディストリビューション名、バージョン、識別子などが記載されており、システムの詳細を知ることができます。

```shell
cat /etc/os-release
```

### 各種サービスが正常に動作しているか調べる

`systemctl`は`systemd`で管理されているサービスの状態確認や操作を行うためのコマンドです。  
例えば、以下のコマンドで特定のサービスの状態を確認できます。

```shell
systemctl status <service name>
```

[systemctl よく使うコマンド一覧](#systemctl-よく使うコマンド一覧)
※ `systemd`は、`Linux`で広く利用されている初期化システムです。システム起動時に各種サービスをまとめて立ち上げ、管理する役割を担っています。

### UFW の状態を調べる

`UFW`は、シンプルなファイアウォール管理ツールですが、通常`/usr/sbin`にインストールされています。  
一般ユーザの`PATH`には`/usr/sbin`が含まれていないため、`-bash: ufw: command not found`と表示されることがあります。  
また、一般ユーザーでは十分な権限がないため、`/usr/sbin`を追加しても、一般ユーザーでは閲覧できません。  
以下のように`sudo`を利用して実行してください。

```shell
sudo ufw status
```

## ユーザー

### ユーザーの作成

新しいユーザーを作成するには、管理者 (root) 権限で以下のコマンドを実行します。  
この段階ではパスワードが設定されていないため、ログインすることはできません。  
ユーザー作成後は、別途パスワードを設定する必要があります。

```shell
sudo useradd <username>
```

### ユーザー一覧の確認

システムに登録されているユーザーの一覧は、以下のコマンドで確認できます。

```shell
cat /etc/passwd
```

### ユーザーにグループを付与する

特定のユーザーを既存のグループに追加するには、管理者 (root) 権限で以下のコマンドを使用します。  
※ 複数のグループに一度に追加する場合、グループ名をカンマ区切りで指定できます。

```shell
sudo usermod -aG <group name> <username>
```

【補足】

- `-gオプション`  
   ユーザーの主グループを変更します。
- `-aGオプション`  
   ユーザーの副グループに追加します。既存のグループはそのまま維持され、新たに指定したグループが追加されます。

## グループ

### ユーザーが所属しているグループを調べる

`groups`コマンドは、指定したユーザーが所属するグループの一覧を表示します。

```shell
groups <username>
```

### グループの作成

新しくグループを作成する場合、管理者 (root) 権限で以下のコマンドを使用します。

```shell
sudo groupadd <new group name>
```

### グループ一覧の確認

システムに登録されている全グループの一覧を確認するには、以下のコマンドを利用します。

```shell
getent group
```

また、グループ情報は`/etc/groups`に記載されているので、`cat`コマンドで内容を確認することもできます。

## パスワード

### パスワードの設定

ユーザーのパスワードを設定、変更するには、次のコマンドを使用します。

```shell
sudo passwd <username>
```

### パスワードポリシーの変更と確認

Debian ではパスワードの有効期限は`/etc/login.defs`、パスワードの基本設定は`/etc/pam.d/common-password`で行います。  
以下は各設定ファイルの該当部分とその解説です。

#### パスワード有効期限の設定（/etc/login.defs）

```shell
# Password aging controls:
#
#	PASS_MAX_DAYS	Maximum number of days a password may be used.
#	PASS_MIN_DAYS	Minimum number of days allowed between password changes.
#	PASS_WARN_AGE	Number of days warning given before a password expires.
#
PASS_MAX_DAYS	30
PASS_MIN_DAYS	2
PASS_WARN_AGE	7
```

#### パスワードの品質と複雑性の設定（/etc/pam.d/common-password）

パスワードポリシーを設定するために、`pam_pwquality.so`という PAM モジュールを利用します。  
このモジュールは、設定されたパラメータに従ってパスワードの品質や複雑性（例：最小文字数、必要な文字種の組み合わせなど）を検証します。

```shell
# here are the per-package modules (the "Primary" block)
password        requisite                       pam_pwquality.so retry=3 minlen=10 difok=7 maxrepeat=3 dcredit=-1 ucredit=-1 lcredit=-1 reject_username enforce_for_root
```

【各設定項目の説明】
| 項目 | 説明 |
|-------------------|----------------------------------------------------------------------------------------|
| PASS_MAX_DAYS | パスワードの使用可能な最大日数（この日数を過ぎるとパスワードの変更が必要になります）。 |
| PASS_MIN_DAYS | パスワード変更間の最小日数（短期間での変更を防ぎます）。 |
| PASS_WARN_AGE | パスワード期限切れの警告を開始する日数。期限が近づくとユーザーに警告が表示されます。 |
| retry | パスワード入力に失敗した際の再試行回数。 |
| minlen | パスワードの最小文字数。短すぎるパスワードを防ぎます。 |
| difok | パスワード変更時に、前回のパスワードと異なる必要がある文字数。 |
| maxrepeat | 同一文字の連続使用を許可する最大回数。 |
| dcredit | 数字が含まれているかの指標。負の値は数字を必須とする度合いを表します。 |
| ucredit | 大文字アルファベットが含まれているかの指標。負の値は大文字を必須とする度合いを表します。 |
| lcredit | 小文字アルファベットが含まれているかの指標。負の値は小文字を必須とする度合いを表します。 |
| reject_username | パスワードにユーザー名が含まれている場合に、変更を拒否するオプション。 |
| enforce_for_root | root ユーザーにも同じパスワードポリシーを適用します。 |

### 上記のポリシーの目的とメリット・デメリット

【目的】

- システムのセキュリティ向上を図るため、ユーザーが推測されにくいパスワードを設定するよう促します。
- パスワードの有効期限や品質に一定の基準を設けることで、不正アクセスのリスクを低減します。

【メリット】

- 強固なセキュリティ  
   複雑なパスワードポリシーにより、攻撃者が容易にパスワードを推測することができなくなる。
- リスク管理  
   パスワードの定期的な変更と品質管理により、万が一の情報漏洩リスクを軽減することができる。
- 監査の容易さ  
   統一されたパスワード管理基準により、セキュリティ監査やポリシーチェックが行いやすくなる。

【デメリット】

- ユーザビリティの低下  
   複雑で頻繁なパスワード更新が求められると、ユーザーがパスワードを覚えにくくなり、ログイン失敗の原因にも繋がる。

## ホスト

### マシンのホスト名の確認

マシンのホスト名は、以下のコマンドで確認できます。

```shell
hostname
```

### ホスト名の変更方法

マシンのホスト名の変更は、管理者 (root) 権限で下記コマンドを実行します。

```shell
sudo hostnamectl set-hostname <new host name>
```

## パーティション

### パーティションの確認

システムのパーティショニング状況は、以下のコマンドで確認できます。

```shell
lsblk
```

## SUDO

### SUDO 設定

SUDO の設定を行うには、管理者 (root) 権限で下記コマンドを実行します。

```shell
sudo visudo
```

以下は、設定ファイルに記述される例です。

```shell
Defaults        env_reset
Defaults        mail_badpass
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
Defaults        requiretty
Defaults        badpass_message="WRONG PASSWORD"
Defaults        logfile="/var/log/sudo/sudo.log"
Defaults        log_input
Defaults        log_output
Defaults        iolog_dir=/var/log/sudo
Defaults        passwd_tries=3
```

【各設定項目の説明】
| 項目 | 説明 |
|------------------|---------------------------------------------------------------------------------------|
| env_reset | `sudo`実行時に環境変数をリセットし、不要な変数が引き継がれないようにします。 |
| mail_badpass | 不正なパスワード入力時に管理者へメールで通知するオプションです。 |
| secure_path | `sudo`実行時に使用される安全なパスを指定します。例："/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin" |
| requiretty | `sudo`コマンド実行時に、TTY（端末）が必要であることを要求します。 |
| badpass_message | 不正なパスワード入力時にユーザーに表示するメッセージを設定します。 |
| logfile | `sudo`の操作ログを記録するファイルのパスを指定します。 |
| log_input | ユーザーの入力内容（キーストロークなど）をログに記録します。 |
| log_output | コマンドの出力をログに記録します。 |
| iolog_dir | 入出力ログファイルを保存するディレクトリを指定します。 |
| passwd_tries | パスワード入力の試行回数の上限を設定し、上限に達した場合は`sudo`の実行を中断します。 |

## UFW

### UFW のステータス確認

`UFW`が起動していることを確認するには、管理者 (root) 権限で下記コマンドを実行します。

```shell
sudo ufw status
```

### 新たなポートを開く

指定した番号のポートを解放するには、管理者（root）権限で以下のコマンドを実行します。

```shell
sudo ufw allow <port number>
```

### 定義済みルールの削除

既存のルールを削除する場合、まずルール一覧を番号付きで表示し、削除対象の番号を確認します。

```shell
sudo ufw status numbered
```

その後、削除対象の番号を指定してルールを削除します。

```shell
sudo ufw delete <number>
```

## SSH

### SSH 接続方法

SSH 接続は、以下のコマンドを使用して行います。  
コマンド末尾に任意のコマンドを指定すると、接続後にそのコマンドが実行され、終了します。

```shell
ssh <username>@<hostname> [command]
```

## Cron

### 設定

下記コマンドを用いて設定を行います。

```shell
crontab -e
```

基本的な記述方法は下記の通りです。

```shell
分 時 日 月 曜日 <実行コマンド>
```

以下は、10 分ごとに特定のシェルスクリプト（例：/etc/cron.d/monitoring.sh）を実行する Cron ジョブの設定例です。

```shell
*/10 * * * * bash /etc/cron.d/monitoring.sh
```

- \*/10 は「10 分ごと」を表します。
- 各アスタリスク（\*）は、時、日、月、曜日の全ての値を対象とすることを示します。

## systemctl よく使うコマンド一覧

【よく使うコマンド一覧】
| コマンド | 説明 |
| --------------------------| ------------------------- |
| `systemctl start ${Unit}` | 指定したユニットを起動します。 |
| `systemctl stop ${Unit}` | 指定したユニットを停止します。 |
| `systemctl restart ${Unit}` | ユニットを停止後、再度起動します。 |
| `systemctl reload ${Unit}` | ユニットの設定を再読み込みします。 |
| `systemctl status ${Unit}` | ユニットの現在の状態を表示します。 |
| `systemctl enable ${Unit}` | システム起動時にユニットを自動で起動するよう設定します。 |
| `systemctl disable ${Unit}` | システム起動時にユニットが起動しないように設定します。 |
| `systemctl is-enabled ${Unit}` | ユニットの自動起動設定が有効かどうか確認します。 |
