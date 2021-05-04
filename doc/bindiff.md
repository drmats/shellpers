# quick console binary diff

```bash
colordiff -W200 -y <(xxd -c 24 a.bin) <(xxd -c 24 b.bin) | most
```
