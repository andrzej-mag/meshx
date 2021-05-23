# Meshx
Service mesh support for Elixir.

`Meshx` is released as group of separate Elixir packages, summary for each package is provided below.

### MeshxConsul
[![Hex Version](https://img.shields.io/hexpm/v/meshx_consul)](https://hex.pm/packages/meshx_consul)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen)](https://hexdocs.pm/meshx_consul)

`MeshxConsul` is a service mesh adapter implementing `Meshx.ServiceMesh` behaviour using HashiCorp [Consul](https://www.consul.io/) as an external service mesh solution. Package manages mesh service and upstream endpoints, which are later consumed by user service providers and upstream clients.

`MeshxConsul` by using external dependencies, Consul as control plane and Envoy/other proxy as data plane, complements user client/server applications with powerful service mesh features:
* [mTLS](https://www.consul.io/docs/connect/connect-internals#mutual-transport-layer-security-mtls) connections,
* service-to-service permissions: [intentions](https://www.consul.io/docs/connect/intentions),
* mesh service [health checks](https://www.consul.io/docs/discovery/checks),
* [load balancing](https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/upstream/load_balancing/load_balancing),
* observability and [UI visualisations](https://www.consul.io/docs/connect/observability/ui-visualization),
* multi datacenter communication using [gateways](https://www.consul.io/docs/connect/gateways).

`Meshx` packages using `MeshxConsul` service mesh adapter to deliver end-user functionality are:
  * `MeshxRpc` - RPC (Remote Procedure Call) functionality,
  * `MeshxNode` - service mesh distribution module.

### MeshxRpc
[![Hex Version](https://img.shields.io/hexpm/v/meshx_rpc)](https://hex.pm/packages/meshx_rpc)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen)](https://hexdocs.pm/meshx_rpc)

`MeshxRpc` can be considered as alternative to Erlang OTP [`:erpc`](https://erlang.org/doc/man/erpc.html) (or [`:rpc`](https://erlang.org/doc/man/rpc.html)) module. `MeshxRpc` restricts request execution scope to single RPC server module to improve operational node security. `MeshxRpc` provides built-in features crucial for binary data transfers: chunking user data into smaller blocks to avoid IO socket blocking and transmission error detection with user configurable asynchronously executed block checksum functions.

`MeshxRpc` is using custom binary communication protocol, hence it doesn't depend on Erlang distribution protocol. `MeshxRpc` fits best in cases where user application requires execution of plain remote functions and doesn't require remote process management features like process linking or monitoring available only for natively distributed nodes. `MeshxRpc` can be used with nodes connected with Erlang distribution if justified by package additional features, otherwise OTP `:erpc` should be used.

`MeshxRpc` primary objective is to work paired with service mesh adapter (`MeshxConsul`) as a user mesh service, however it can be used with any other data transport solution, eg. ssh port forwarding or VPN. For special use cases it can work standalone: `MeshxRpc` server and client running on the same host and sharing common connection socket.

`MeshxRpc` doesn't offer data encryption, authorization or authentication mechanisms as those are natively provided by service mesh environment.

### MeshxNode
[![Hex Version](https://img.shields.io/hexpm/v/meshx_node)](https://hex.pm/packages/meshx_node)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen)](https://hexdocs.pm/meshx_node)

`MeshxNode` delivers Erlang style nodes connectivity by registering  special "node service" using service mesh adapter. Communication between nodes is realized using service mesh sidecar proxies and upstreams. Data traffic is secured with mTLS, managed by service mesh application control plane (e.g. Consul).

MeshxNode can be considered as alternative to Erlang Port Mapper Daemon ([EPMD](https://erlang.org/doc/man/epmd.html)) and distribution module (usually [`:inet_tls_dist`](http://erlang.org/doc/apps/ssl/ssl_distribution.html) or `:inet_dist`).

`MeshxNode` running on top of service mesh data plane for inter-node communication provides high availability feature for distributed nodes.

Users are free to use any mesh service management features provided by external mesh application or L4 proxy software. Consul service intentions, tokens or ACLs to manage "node service" access permissions might be an interesting feature to consider here.

### Meshx
[![Hex Version](https://img.shields.io/hexpm/v/meshx)](https://hex.pm/packages/meshx)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen)](https://hexdocs.pm/meshx)

`Meshx` package doesn't offer any end-user functionality. `Meshx` should be used by developers building new service mesh adapters implementing `Meshx.ServiceMesh` behavior.

Service mesh adapter in practice should be reasonably thin layer between user application using `Meshx` packages and external software providing service mesh solution. Mesh adapter should use third party application API to implement functionality required by `Meshx.ServiceMesh` behavior. As described earlier `Meshx` is released with HashiCorp Consul adapter - `MeshxConsul`.
