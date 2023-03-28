# OpenSSH

## port forwarding

Forward all requests to `localhost:LOCAL_PORT` to `remote.example.com:REMOTE_PORT`:

```bash
ssh -L LOCAL_PORT:localhost:REMOTE_PORT user@remote.example.com
```

Useful for remote access to remote services listening only on localhost.




## remove host identity from `~/.ssh/known_hosts`

```bash
ssh-keygen -R host-to-remove
```
