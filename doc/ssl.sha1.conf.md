# legacy SSL system-wide configuration

- enable SHA-1 signatures
- `error: SSL_ERROR_UNSUPPORTED_HASH_ALGORITHM`
- **unsafe**

```
$ update-crypto-policies --set LEGACY
```
