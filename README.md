# Jekyll plugin to render documents in additional ways

This plugin allows to automatically generate an extra page
for each document in specified collection(s).
Additionally generated pages
can be assigned a different layout and/or extra frontmatter variables,
and will be placed under specified path.

## Use cases

* You have documentation for your desktop app
  available via your main site as usual and want to reuse the same pages
  in context of app’s built-in web-based help, similar to e.g. what Xcode does.

  In this scenario you may want new pages to provide the same content
  in a different layout (perhaps excluding some page elements).

* You want to output machine-readable JSON for each document.

## Configuration

Specify the following in your `_config.yml`:

```yaml
duplicate_documents:
  in_collection: <your collection name>
  under_url_prefix: <path to render documents under>
  format: <html or json>

  # These two are optional
  with_layout: <layout name>
  with_frontmatter:
    <variable>: <value>
    ...
```

## Notes and limitations

* Does not work with AsciiDoc or other pre-processed formats.
  [Issue](../../../../riboseinc/jekyll-duplicate/issues/1).

* In case of JSON, you must still use a layout to build your structure.
  Specify `layout: nil` in your layout.
  Use `jsonify` filter to escape values or convert Ruby structures to JSON.

* Currently, no nesting in extra frontmatter is allowed.
  [Issue](../../../../riboseinc/jekyll-duplicate/issues/2).

* If any frontmatter specified clashes with page’s original frontmatter,
  frontmatter from jekyll-duplicate configuration will prevail.

## Caution

Pages with duplicate content are discouraged by search engines.

You may, for example, want to make sure that extra pages, if they’re HTML,
are not linked to from the “main site” and do not get indexed.

## Contributing

PRs are welcome.

## Release process

* Update version number in `.gemspec` and commit your change.

* Run `./develop/release` to publish new gem version, tag the repo and push to GitHub.