defmodule EventQueues do
  @moduledoc false

  def queue(opts) do
    quote do
      use EventQueues.Queue, unquote(opts)
    end
  end

  def handler(opts) do
    quote do
      use EventQueues.Handler, unquote(opts)
    end
  end

  def announcer do
    quote do
      use EventQueues.Announcer
    end
  end

  defmacro __using__(opts \\ []) do
    key = Keyword.get opts, :type, :queue

    case key do
      :queue -> queue(opts)
      :handler -> handler(opts)
      :announcer -> announcer()
    end
  end

  defmacro defevents(events) when is_list events do
    quote do
      EventQueues.Announcer.defevents unquote(events)
    end
  end
end
