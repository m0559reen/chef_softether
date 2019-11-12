```
.
├── .chef
│   └── knife.rb
├── Dockerfile
├── README.md
├── cookbooks
│   └── softether
│       ├── attributes
│       │   └── default.rb
│       ├── files
│       │   └── default
│       │       └── vpnserver
│       ├── recipes
│       │   ├── default.rb
│       │   └── softether.rb
│       └── templates
│           └── default
│               └── softether-radius.txt.erb
├── docker-compose.yaml
└── key.pem
```

# cookbook:softether
https://qiita.com/m0559reen/items/87d86968f5cc36fbff1c

# chef
---

### depends on
docker

### install

```
## download private-key from

## only 1st time
docker-compose build 

## alias
alias dchef='docker-compose run --rm chef'

## run single command
dchef knife node list
```

```
k
```

### knife zero bootstrap node
bootstrap(chef-clientのインストール)
```
$ knife zero bootstrap <private-ip> --node-name <new-nodename>
$ ls nodes/
<new-nodename>.json
```

node一覧表示
```
$ knife node list
```

### rolesの追加/編集
```
$ knife role create <role-name>
$ ls roles/
<role-name>.json

$ knife role edit <role-name>
"run_list": [
  "recipe[base::default]"
],
```

### run_listの編集
```
$ knife node edit <node-name>
"run_list": [
  "role[base]"
]
```

### レシピ反映
```
$ knife zero converge "name:*" --why-run
$ knife zero converge "name:*"
```

### 特定のレシピ反映
```
$ knife zero converge "name:*" -o recipe[user::default]
```

### リモートコマンド実行
```
$ knife ssh "name:*" "hostname"
```
