# regular_rectangle_packer

Sometimes in Flutter you just want to lay out some squares or rectangles tightly and uniformly. 

- You want them all to fit on screen/in their parent...
- You want them to all be a certain shape...
- You don't want too much empty space in your layout...
- You don't particularly care how horizontal/vertical the items are laid out.

`ListView`s tend to take up too much horizontal space. `Wrap` widgets are good but wont resize to fit everything on screen, and aren't specialized for items of fixed proportion.

Introducing the `RegularRectanglePacker`. It's a bit like a `Wrap` widget but it's designed for items of fixed aspect ratio, and it fits them all in the parent widget, with constant size, reasonably tightly.

Currently an unpublished work-in-progress.
