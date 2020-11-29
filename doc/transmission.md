# transmission


## blocklist

```bash
$ wget http://john.bitsurge.net/public/biglist.p2p.gz
$ gzip -d biglist.p2p.gz
```

## daemon

```bash
$ cd downloads
```

### foreground

```bash
$ transmission-daemon -f -p 9091 -P 51414 -w ./ -ep -c ./torrents/ -l 50 -o -w ./ -b
```

### background

```bash
$ transmission-daemon -p 9091 -P 51414 -w ./ -ep -c ./torrents/ -l 50 -o -w ./ -b -e ./transmission.log
```

## set limits with remote

```bash
$ transmission-remote -d 200 -u 5
```

## add magnet-link and start with remote

```bash
$ transmisison-remote -a 'magnet:...' -s
```

## current status

```bash
$ transmission-remote -l
```
