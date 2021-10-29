# :card_index_dividers: Fileserver

This is a nginx server adapted as a simple fileserver using webdav technology.

Is based on this project: https://github.com/geohot/minikeyvalue/

## Build and publish

```
make docker && make release
```

## SSL

A cert should be generated and fileserver_ssl.conf file should be used. 

Besides of the security reasons to use SSL is the reason to use HTTP2 protocol with nginx.
