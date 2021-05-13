defmodule Meshx.ServiceMesh do
  @moduledoc """
  todo: Documentation will be provided at a later date.

  Please check `MeshxConsul` for example service mesh adapter implementation.
  """
  @type address() ::
          {:tcp, ip :: :inet.ip_address(), port :: :inet.port_number()}
          | {:uds, path :: String.t()}

  @callback connect(
              upstreams :: [upstream :: atom() | String.t() | map()],
              template :: map(),
              proxy ::
                nil
                | {proxy_service_name :: String.t() | atom(), proxy_service_id :: String.t() | atom()}
            ) ::
              {:ok, []}
              | {:ok, [{:ok, addr :: address()} | {:error, err :: term()}]}
              | {:error, :invalid_state}
              | {:error, :service_not_owned}
              | term()

  @callback disconnect(
              upstreams :: [upstream :: atom() | String.t()],
              proxy_service_id :: nil | atom() | String.t(),
              restart_proxy? :: boolean()
            ) ::
              {:ok, []}
              | {:ok, [deleted_upstream_name :: String.t()]}
              | (err :: term())

  @callback start(
              params ::
                (name :: atom() | String.t())
                | {name :: atom() | String.t(), id :: atom() | String.t()}
                | map()
                | any(),
              template ::
                [
                  registration: map(),
                  ttl: nil | %{id: String.t()},
                  proxy: nil | [String.t()]
                ]
                | any(),
              force_registration? :: boolean(),
              timeout :: non_neg_integer()
            ) ::
              {:ok, service_id :: String.t(), addr :: address()}
              | {:ok, :already_started}
              | {:error, :invalid_state}
              | {:error, :service_not_owned}
              | {:error, :service_alive_timeout}
              | term()

  @callback stop(service_name :: atom() | String.t()) :: :ok | {:error, :service_not_owned}
end
