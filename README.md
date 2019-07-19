# Dynamic Edge Side Includes using Varnish and Traefik

[Edge Side Includes](https://en.wikipedia.org/wiki/Edge_Side_Includes) (ESI) with [Varnish](https://varnish-cache.org/) work basically like a charm. But if you want to dynamically add new backends the things became much more complicated. [Traefik](https://traefik.io) as reverse proxy can help here.

Traefik is able to monitor docker services and allows to update the configuration automatically without a restart. In this example the Vernish Cache is configured as an entry point with only one backend, the Traefik reverse proxy. All docker services register themselves using `traefik.frontend.rule` labels dynamically. You can add new services without any additional configuration.

We'll use two options of Traefik, defining a path mapping for `frontend a` and adding a hostname for `frontend b`.


## Test it
Let's start the reverse_proxy and vernish containers first:
```
docker-compose start varnish reverse-proxy
```

A HTTP GET request to ``http://localhost/a`` or ``http://b.localhost`` should lead to a `404` error and that's fine for now.

So let's bring the first front end service up

```
docker-compose start frontend-a
```

While ``http://b.localhost`` remains not available a GET request to ``http://localhost/a`` URL should return some content now. Some parts are still missing, so let's start the last service

```
docker-compose start frontend-b
```

Now both side should be available and complete.
