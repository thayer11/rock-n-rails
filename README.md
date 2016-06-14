#Rock 'n Rails!

For this morning exercise we're going to be synthesizing all our Rails knowledge to build a record collection! At the bottom of this file you can find a link to a completed solution.

###User stories

*User should be able to...*

1) See all the records on `records#index`

2) See a single record on `record#show`

3) See a form to create a new record on `record#new`

4) Submit the new record form to `record#create` to create a new record and then be redirected back to record index.

## Model

#### `Record` Model
A `Record` should have the following attributes:

* title — String
* artist — String
* year — Integer
* cover_art — String
* song_count — Integer

```bash
rails g model record title:string artist:string year:integer cover_art:string song_count:integer
```

* Create a database for your application to use

```bash
rake db:create
```

* Run the migration that was generated to create a new table in the database.

```bash
rake db:migrate
```

* Play with your new `Record` model in the rails console:

```bash
rails console
> Record.all #=> []
> Record.create({title: "Test Record"})
```

* Stop and commit!

#### `Record` seed task
* In `db/seeds.rb` create some records!

`db/seeds.rb`.

```ruby
# Wipe the database
Record.destroy_all
# Let's create a bunch of records
Record.create([
  {
    title: "On Avery Island",
    artist: "Neutral Milk Hotel",
    year: 1996,
    cover_art: "https://upload.wikimedia.org/wikipedia/en/7/73/On_avery_island_album_cover.jpg",
    song_count: 12
  },
  {
    title: "Everything All the Time",
    artist: "Band of Horses",
    year: 2006,
    cover_art: "https://upload.wikimedia.org/wikipedia/en/5/51/BandofHorsesEverythingalltheTime.jpg",
    song_count: 10
  },
  {
    title: "The Flying Club Cup",
    artist: "Beirut",
    year: 2007,
    cover_art: "https://upload.wikimedia.org/wikipedia/en/4/4c/The_Flying_Club_Cup.jpg",
    song_count: 13
  }
])
```

* Run the seed file!

```bash
rake db:seed
```

* Check that everything was done correctly, run `rails console` or just `rails c` and inside run `Record.all`. Make sure that you can see an array of all the records from your seed file. Exit by typing `exit`.

* Stop and commit!


## View, Routes, and Controllers
**See all the records on `records#index`**

* Start the server with `rails s` & head to `localhost:3000/records`
    - You should see an error complaining that "no route matches...". What does that tell you?

* Let's add our first RESTful route for our `Records` resource!

In `config/routes.rb`, add the following route(s):

```ruby
get "/records" => "records#index", as: 'records'  # add me!
#get "/records/:id" => "records#show", as: 'record'
#get "/records/new" => "records#new", as: 'new_record'
#post "/records" => "records#create"
```

* Now, refresh the page, and you should see it complain about a missing controller!

Let's generate our records controller!

```bash
rails g controller records
```

In `records_controller.rb` let's add:

```ruby
def index
  render :index # optional
end
```

* Refresh the page, and you should see it complain about a missing view!

Let's create `views/records/index.html.erb` and add the following html:

```html
<h1>Rock 'n Rails! (records#index)</h1>
```

* Refresh the page, and you should see the above HTML rendered. Yay!

Now let's connect our model. Update your `index` action in `records_controller.rb` to grab all the records:

``` ruby
def index
  @records = Record.all
  # render :index
end
```

And then let's also update the view to render a list of records:

``` html
<% @records.each do |record| %>
  <p>Title: <%= record.title %></p>
  <p>Artist: <%= record.artist %></p>
  <img src="<%= record.cover_art %>">
<% end %>
```

* Refresh the page and you should see your list of records! Good work!

**See a single record on `record#show`**

* For each record in the `record#index` view let's create an anchor tag that will link to e.g. `records/1`, `records/2`, `records/3`

`views/records/index.html.erb`.

```html
<h1>Rock 'n Rails!</h1>
<% @records.each do |record| %>
  <p>Title: <%= record.title %></p>
  <p>Artist: <%= record.artist %></p>
  <img src="<%= record.cover_art %>">
  <br>
  <!-- anchor tag that links to a show page -->
  <a href="/records/<%= record.id %>">Show page</a><br> <!-- bad -->
  <%= link_to "Show page", record_path(record) %>       <!-- good -->
<% end %>
```

* Refresh the page, and click on one of the links. What error do you see?

* Let's add our second RESTful route for our `Records` resource!

In `config/routes.rb`, add the following route(s):

```ruby
get "/records" => "records#index", as: 'records'
#get "/records/new" => "records#new", as: 'new_record'
get "/records/:id" => "records#show", as: 'record' # add me!
#post "/records" => "records#create"
```

* Refresh the page. What error do you see?

* We need to create the `records#show` action now. And we need to grab the `id` from the parameters and use it to find the matching record in the database and pass it to the view.

`records_controller.rb`

```ruby
  # ...

  def show
    @record = Record.find(params[:id])
    render :show #optional
  end
```

* Refresh the page. What error do you see?

* Let's create `views/records/show.html.erb` and add the following html:

```html
<h1>Rock 'n Rails! (records#show)</h1>
```

* Refresh the page and make sure you see the HTML above rendered.

* Now, in your `records#show` view, `views/records/show.html.erb` display the record that is being passed in.

```html
<img src="<%= @record.cover_art %>">
<h1><%= @record.title %></h1>
<h2>by <%= @record.artist %></h2>
<p>Year: <%= @record.year %></p>
<p>Song Count: <%= @record.song_count %></p>
<%= link_to "Back", records_path %>
```

**See a form to create a new record on `record#new`**

* Let's create a link on *every* page that will get us to a form that creates a new record, which lives on `/records/new`. We can edit the `application.html.erb` file which lives in `views/layouts/` to accomplish this. Inside the file add an anchor tag just above the `yield` statement in the `<body>`.

```html
<body>

<!--Every page will have this link to create a new record-->
<a href="/records/new">Make a New Record</a><br>        <!-- bad -->
<%= link_to "Make a New Record", new_record_path %>     <!-- good -->

<%= yield %>

</body>
```

When you visit `localhost:3000/records/new`, you should see an error.

* Let's add our third RESTful route for our `Records` resource!

In `config/routes.rb`, add the following route(s):

```ruby
get "/records" => "records#index", as: 'records'
get "/records/new" => "records#new", as: 'new_record'  # add me! order matters!
get "/records/:id" => "records#show", as: 'record'
#post "/records" => "records#create"
```

* Refresh and you should see a new error, complaining about the controller.

* We need to create the `records#new` action now.

`records_controller.rb`

```ruby
  # ...

  def new
    render :new #optional
  end
```

* Now we need to create `views/records/new.html.erb` using a rails HTML form helper. Let's make all fields required.

```html
<%= form_for @record do |f| %>
  <span>Title: </span>
  <%= f.text_field :title, required: true %><br>
  <span>Artist: </span>
  <%= f.text_field :artist, required: true %><br>
  <span>Year: </span>
  <%= f.number_field :year, required: true %><br>
  <span>Cover art: </span>
  <%= f.url_field :cover_art, required: true %><br>
  <span>Song count: </span>
  <%= f.number_field :song_count, required: true %><br>
  <%= f.submit %>
<% end %>
```

* This form will not work yet. That's because we reference `@record` in the form but it's not defined. Let's define `@record` in our controller and pass it into our view. All we need it to be equal to is a new instance of a the `Record` model.

`app/controllers/records_controller.rb`

```ruby
  # ...

  def new
    @record = Record.new
    render :new #optional
  end
```

* Refresh and you should see the rendered form!

**Submit the new record form to `record#create` to create a new record and then be redirected back to record index.**

* Now that our forms works, it will automatically `POST` to `/records`. Try it and you'll see our next error!

* Let's add our fourth RESTful route for our `Records` resource!

In `config/routes.rb`, add the following route(s):

```ruby
get "/records" => "records#index", as: 'records'
get "/records/new" => "records#new", as: 'new_record'
get "/records/:id" => "records#show", as: 'record'
post "/records" => "records#create"  # add me!
```

* Nothing is happening in the `records#create` controller as of yet so we need to actually create a new record there. In order to do that we must pull out the data submitted from our form from the `params` object and create a new record with it.

`app/controllers/records_controller.rb`.

```ruby
  def create
    Record.create(
      # this is known as strong parameters, and is done for security purposes
      params.require(:record).permit(:title, :artist, :year, :cover_art, :song_count)
    )
  end
```

* You may wonder what all the business is with `.require(:record).permit(...)` is. This is known as [**strong parameters**](http://edgeguides.rubyonrails.org/action_controller_overview.html#strong-parameters) and tells our applications these are the fields we will accept. Its good security practice to help prevent users accidentally updating sensitive model attributes.

* Additionally we can refactor this code to make it look better. We can **encapsulate** our strong parameter logic into a method called `record_params`. Let's make that a private method, since only the controller itself will ever use it. At the bottom of `RecordController` we can write:

`app/controllers/records_controller.rb`.

```ruby
# public methods up here

  private

  def record_params
    params.require(:record).permit(:title, :artist, :year, :cover_art, :song_count)
  end

end # end of class
```

* Now our `create` method can take advantage of the `record_params` method, which simply will output an object of key value pairs our `Record` model can use to create a new record. Also let's tell it to redirect to the index page once it's created the record.

`app/controllers/records_controller.rb`.

```ruby
  def create
    Record.create(record_params)
    redirect_to('/records')
  end
```

Congrats! We've complete all the user stories! Please see the solution branch if you have questions!
