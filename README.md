# object-view

Ruby GEM providing object oriented HTML generation.

MIT License


Sample Usage
------------
```ruby
include ObjectView

 # Create a page
page = ObjectView::Page.new

 # Add a div to the page
div = page.body.add Div.new

 # Give the div some style attributes.  This is equivalent to style='border: 1px solid black; margin-left: 10px'
 div.style = {border: '1px solid black', margin_left: '10px'}

 # Create a table inside the div
table = div.add Table.new

 # Give table a css class:
table.css_class = '.borderedTable'

 # Add cells with text to table
table.row(['Cell 1', 'Cell 2', 'Cell 3'])

 # Add cells with Span, Divs and Text
table.row(Span.new("Cell 1"), Div.new("Cell 2"), "Cell 3")

 # Make list
ul = page.body.add Ul.new
ul.add Li.new("First Element")
ul.add Li.new("Second Element")
ul.add Li.new("Third Element")
```

page.render() produces:
```html
<html>
   <head>
      <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
   </head>
   <body>
      <div style="border: 1px solid black; margin-left: 10px">
         <table class=".borderedTable">
            <tbody>
               <tr>
                  <td>Cell 1</td>
                  <td>Cell 2</td>
                  <td>Cell 3</td>
               </tr>
               <tr>
                  <td><span>Cell 1
                     </span>
                  </td>
                  <td>
                     <div>Cell 2</div>
                  </td>
                  <td>Cell 3</td>
               </tr>
            </tbody>
         </table>
         <a href="/home">
         Home Page
         </a>
      </div>
      <ul>
         <li>
            First Element
         </li>
         <li>
            Second Element
         </li>
         <li>
            Third Element
         </li>
      </ul>
   </body>
</html>

```

