# LunaApp

To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## To test

Go to page [`http://localhost:4000/open_graphs`](http://localhost:4000/open_graphs), the landing page will be as below 
  ![image](doc/preview.png)


1) input a test website (eg: <https://www.getluna.com/>), which has been processed before (seed data in local DB), all meta data related to this website's can be shown, with `image` being shown as an image.

  ![image](doc/preview_1.png)

2) input another test website, a new task will be created to parsing the meta data and update its information to DB once parsing is done.

## Learn more

* Official website: <https://www.phoenixframework.org/>
* Guides: <https://hexdocs.pm/phoenix/overview.html>
* Docs: <https://hexdocs.pm/phoenix>
* Forum: <https://elixirforum.com/c/phoenix-forum>
* Source: <https://github.com/phoenixframework/phoenix>
