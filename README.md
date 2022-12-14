# Open Graph preview

This app is to show a preview of an open graph. Please refer to [open graph protocol](https://ogp.me/) for more information. It completes these tasks:

- Parse the open graph information based on the input url, and save the parsed information to local database.
- Show preview of the open graph, based on information in the database.

## To setup

To start your Phoenix server:

- Install dependencies with `mix deps.get`, `mix deps.compile`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## To test

Go to page [`http://localhost:4000/open_graphs`](http://localhost:4000/open_graphs), the landing page will be as below
      ![image](doc/landing_page.png)

1) input a test website (eg: <https://ogp.me/>), which has been processed before (seed data in local DB), all meta data related to this website's can be shown, with `image` being shown as an image.

    ![image](doc/preview_opg.me.png)

2) input another test website, a new task will be created to parsing the meta data and update its information to DB once parsing is done. UI will display the following without waiting for task to complete.

    ![image](doc/processing.png)

3) when the data is processed, the 2nd time the user query the same url (eg: <https://www.google.com> ), the correct preview page will be rendered.

    ![image](doc/preview_google.com.png)

4) when the 'url' doesn't have the correct og metadata, and cannot be parser correctly, error information should be displayed, eg:  
   ![image](doc/preview_error.png)

NOTE: The UI won't change automatically when DB is updated. A User can manually refresh the page to get the updated preview.

- the async task can be quickly within 1 or two seconds
- Before the task is done, there won't be multiple tasks created. New tasks can only be created when in "pending" status (not in other status)
- it can be done with js/react to query refresh the page if needed.
- or use pub/sub method
*

## Todo

- unit tests

- code clean-up
