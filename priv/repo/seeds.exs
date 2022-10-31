# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LunaApp.Repo.insert!(%LunaApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LunaApp.OpenGraphs

{:ok, _graph} =
  OpenGraphs.create_open_graph(%{
    url: "https://www.getluna.com/",
    image: "https://socialsharepreview.com/images/social-share-preview-og.jpg",
    title: "Social Share Preview – Check social media link previews",
    status: "ready",
    type: "web",
    metadata: %{
      description:
        "Check how the link previews of a website look like on Facebook, Twitter, LinkedIn & Pinterest. Use our ► debugger or ► free browser extensions!",
      viewport: "width=device-width, initial-scale=1"
    }
  })
