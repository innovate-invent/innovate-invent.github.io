---
title: A begging letter to SSG template developers
excerpt: A plea to properly design SSG templates and their content
tags: [ssg, template, theme, hugo, jekyll, static site generator]
toc: true  
toc_sticky: true  
published: true
---

When ever I set up a website with a static site generator (SSG) such as Hugo or Jekyll, the first thing I do is have a look at
what existing themes/templates are available. I am always disappointed to find that even paid templates do not handle
content correctly. They are requiring textual data to be stored in a YAML document and the navigation is stored in a
separate document or global site configuration. This complicates maintenance, isn't very Git friendly, and complicates
training of less technical content editors.

## The Content

Some templates encountered stored all posts in a single YAML file: `data/posts.yaml`

```yaml
posts:
  - title: Post 1
    date: 2020-02-08
    body: |
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna 
      aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur 
      sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  - title: Post 2
    date: 2020-03-08
    body: |
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna 
      aliqua.
  - title: Post 3
    date: 2020-07-09
    body: |
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur 
      sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
```

Each of these posts should have been stored in their own markdown files with respective front-matter. Storing each unit
of content or 'object' (be it a post, page, update, or content fragment of any type) in a separate file allows
conventional file system tools to manage and manipulate the objects. Having the content in separate files also
significantly reduces the possibility of a merge conflict when tracking with Git. 

The last and possibly most important point is that having each object in a separate markdown file makes it much easier 
for non-technical editors to interact directly with the content. As a YAML file, the editor is expected to understand 
and maintain the YAML syntax, which can get sticky especially when including free form text and all the reserved 
characters and indentation that come with it. With markdown, the files can be created with a user-friendly templating 
application (such as Hugo's archetype system) that handles the front-matter syntax for the user, and then they are free 
to enter whatever content into the document, worry free of YAML syntax.

Here is the above example rewritten as markdown files:

```markdown
posts/2020-02-08-post-1.md
---
title: Post 1
---
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
```

```markdown
posts/2020-03-08-post-2.md
---
title: Post 2
---
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
aliqua.
```

```markdown
posts/2020-07-09-post-3.md
---
title: Post 3
---
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
```

Notice that the date is stored in the file name and can be extracted by the SSG. A common front-matter field, the 'slug', 
is also stored in the file name. This file naming scheme allows sorting by date, and deduplicating information
between the file name and front-matter.

Another example is a page with numerous sections having its content stored as YAML. This manifests by either storing it
as a separate YAML document or loading up the front-matter of a document with large textual fields. The idea is that 
storing all content as structured data makes it easy to work with in the template code, but this is wrong. Your SSG 
provides a way to store structured data as files and folders, and provides template mechanisms to easily work with it.

```yaml
data/about.yaml
---
about:
  enable : true
  title : About Us
  about_item :
  - icon : ti-ruler-pencil # themify icon pack : https://themify.me/themify-icons
    title : We're Creative
    content : Lorem ipsum dolor sit amet, consectetur adipisicing elit. Velit, nihil, libero, perspiciatis eos provident laborum eum dignissimos.

  - icon : ti-cup # themify icon pack : https://themify.me/themify-icons
    title : We're Professional
    content : Lorem ipsum dolor sit amet, consectetur adipisicing elit. Velit, nihil, libero, perspiciatis eos provident laborum eum dignissimos.

  - icon : ti-thought # themify icon pack : https://themify.me/themify-icons
    title : We're Genius
    content : Lorem ipsum dolor sit amet, consectetur adipisicing elit. Velit, nihil, libero, perspiciatis eos provident laborum eum dignissimos.
```

This data should have been stored as individual markdown files with a structure similar to:

```
content
└── about
    ├── index.md  # defines overall page with page front-matter
    ├── item-creative.md  # section markdown
    ├── item-professional.md  
    └── item-genius.md  
```

Yes, having a separate file for a small amount of content can feel like it is overdone, but if the template dynamically 
scans for the files, then sections can be added and removed without needing to edit the template. Each fragment could be 
potentially rendered differently based on its front-matter. If requirements ever change and the content or front-matter 
needs to be greatly expanded for each element, then everything is already in place to make that happen. The overall goal 
is to keep textual content in a format intended to store textual data.
See [the issue discussed further](https://github.com/gohugoio/hugo/issues/4292) for the Hugo SSG.

## The Navigation Menu

How the navigation configuration is managed is a common issue found in many if not most themes/templates encountered.
There is no reason that the navigation bar configuration should be stored in a central location, that needs to be
updated independent of the pages that the navigation represents. I should be able to fully remove a page from the site
by simply deleting the markdown file. Everything related to that page should be kept with the markdown file, not spread 
over the entire project structure.

Here is an example front-matter for a page, with navigation annotations:

```yaml
---
title: Page 2
draft: false  # Hides the page from the navigation or any listing
url: /page1  # optional persistent url path, defaults to slug
tags: [ ]
nav: # if you put all nav options under a namespace, then you can optionally remove the page from the nav bar by setting `nav: false`
  weight: 1  # Used to sort the navigation menu items
  parent: page-1  # slug of the parent navigation item, if absent or null then top most navigation menu
  other:  # other arbitrary options for the navbar item
---
```

The SSG should allow you to globally iterate the project markdown files and read out the front-matter. Aggregate the
navigation options into a navigation bar, and you are done. No need to maintain an external configuration or navigation
hierarchy. Add front-matter values to suit the specifics of your navigation menu with useful defaults. It is easy for
users to understand what is happening here and doesn't require parsing through an entire SSG global configuration file.

Additionally, there is nothing wrong with having a markdown file with only front-matter. This is used when you want to
have a navigation item that is only a parent for other items. It creates a placeholder in the project for if you ever
decide to associate text with that item.

## The plead

Non-technical users understand (at least at a basic level) how to work with files, and at the end of the day I want to 
be able to hand off a website to someone and have them able to manage the site content without requiring my involvement 
for every change.

Please, please, PLEASE! Design your SSG templates/themes to use markdown files any time there are objects with
associated text. Those objects should manage their own navigation settings, so that when the file is added or removed,
that is the only change required. 
