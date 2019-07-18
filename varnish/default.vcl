vcl 4.0;

backend default {
  .host = "reverse-proxy";
  .port = "80";
}

sub vcl_backend_response {
  set beresp.do_esi = true; // Do ESI processing
  set beresp.ttl = 0 s;    // Sets the TTL
}
