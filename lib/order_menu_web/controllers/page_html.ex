defmodule OrderMenuWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use OrderMenuWeb, :html

  embed_templates "page_html/*"
end
