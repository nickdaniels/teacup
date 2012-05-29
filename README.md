Teacup
======

A community-driven DSL for creating user interfaces on the iphone.

By including the `Teacup` module, you can easily create layouts that adhere to
the [iOS user interface guidelines][iOS HIG], and it's an easy way to assign labels,
delegators, and datasources.

The goal is not to simply rename CocoaTouch method names, but to offer a
rubyesque (well, actually a rubymotion-esque) way to create an interface.

Using stylesheets and layouts, it makes coding an iOS app like designing a website with HTML and CSS.

**Check out a working sample app [here](https://github.com/rubymotion/teacup/tree/master/samples/Hai)!**

#### Installation

First get the teacup library into your local project using git submodules:

```bash
$ git submodule add https://github.com:rubymotion/teacup vendor/teacup
```

Then add the teacup library to your Rakefile:
```
  # Add libraries *before* your app so that you can access constants they define safely
  #
  dirs = ['vendor/teacup/lib', 'app']

  # require all the directories in order.
  app.files = dirs.map{|d| Dir.glob(File.join(app.project_dir, "#{d}/**/*.rb")) }.flatten
```


#### Showdown

Regular

```ruby
class SomeController < UIViewController
 def viewDidLoad

  @field = UITextField.new
  @field.height = 50
  @field.width  = 200
  view.addSubview(@field)

  @search = UITextField.new
  @search.height = 50
  @search.width  = 200
  @search.placeholder = 'Find something...'
  view.addSubview(@search)

  true
 end
end
```

Teacup

```ruby
# Stylesheet

Teacup::Stylesheet.new(:IPhone) do

 style :field,
  height: 50,
  width:  200

 style :search, extends: :field,
  placeholder: 'Foo...'

end

# Controller

class SomeController < UIViewController

 def viewDidLoad
  view.addSubview(Teacup.style(:field, UITextField.new))
  view.addSubview(Teacup.style(:search))
  true
 end

end
```

Development
-----------

*Current version*: v0.0.0 (or see `lib/teacup/version.rb`)

*Last milestone*: Pick a name

*Next milestone*: Pick a DSL

teacup, being a community project, moves in "spurts" of decision making and
coding.  Only the name — both the least and most important part :-) — is
decided.

We would love suggestions of any sort, and we're always free over at the `#teacuprb` channel on `irc.freenode.org`.


Ideas that proposals should keep in mind
----------------------------------------

1. output will conform, unless explicitly *disabled* to the [iOS HIG][]
2. should provide a few useful layouts (see [readme for layout proposals](teacup/tree/master/proposals/layout)):
     * basic: vertically arranged "things", or
     * form: label/input combinations arranged in a table
     * navbar: with ability to customize the buttons that get placed at the top
     * tabbar: similar, but with the tabs at the bottom instead of nav at the top
     * splitview: A splitview controller (for iPad Apps) with sane navigation defaults, nice loading webviews and JSON to populate the items in the popover menu

3. layouts should have ways of placing things relative to edges, so placing a
   label or nav at the "bottom" that spans the entire width should be *easy*.
   (This means we'll need to check for ipad or iphone.)
4. actions are either blocks, defined inline, or target/action combos (e.g.
   `target: self, action: :my_method`)
5. there should be a consistent "styling" language, preferably in a separate
   file, something that could be handed to a designer.  this is the BIG item!
6. teacup should take a little `config` block for easy configuration
7. Ideally, there should be some way to "inherit" styles in this language. So you can define a basic layout for all platforms and then tweak (see [readme for style proposals](teacup/tree/master/proposals/styles))

[iOS HIG]: http://developer.apple.com/library/ios/#DOCUMENTATION/UserExperience/Conceptual/MobileHIG/Introduction/Introduction.html

Bugs
----

Please, do *not* hesitate to report any bugs you find with our source at the [Issues](https://github.com/rubymotion/teacup/issues) page.

Use cases
---------

Problems to solve...

1. TableViewCell:

        **************************************
        * |======| Title Goes here, bold     *
        * | icon |                           *
        * |======| mm/dd/YYYY     more info  *  <= smaller, gray captions
        **************************************

2. iPhone address book entry:

        ************************
        * <back=  Joey  [save] * <= navigation controller
        *----------------------*
        * |==|  [ Joey       ] *
        * |:)|  [ Joe        ] * <= icon, and names in text fields
        * |==|  [ McBobby    ] *
        *                      *
        * Address [ 123 St.  ] * <= labels and text fields
        * Phone   [ 123-4567 ] *
        *                      *
        * Notes                *
        * /------------------\ *
        * | What a great     | *
        * | guy!             | *
        * \------------------/ *
        *                      *
        * ( + add field      ) *
        * ( ! delete !       ) * <= red!
        ************************

3. iPad drawing program layout!

                  V split view
        ************************************
        * Drawings |  [+]  [x]  [>]        * <= toolbar, add, trash, send/forward
        *==========|-----------------------*
        * Square > |                       *
        * Box    > |                       *
        *.Circle.>.|     O                 *
        *          |                       *
        *          |-----------------------*
        *          | [/] [#] [O] [T]       * <= toolbar, black. pen, box, circle, text
        ************************************

Good luck!
